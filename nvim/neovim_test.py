#!/usr/bin/env python3

from __future__ import annotations

import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import Any


CONFIG_DIR = Path.home() / ".config" / "nvim"
INIT_LUA = CONFIG_DIR / "init.lua"
RESULT_PREFIX = "__NEOVIM_AUDIT_RESULT__"

NVIM_TIMEOUT = 15


LANGUAGES: dict[str, dict[str, Any]] = {
    "Python": {
        "filename": "audit_python.py",
        "filetype": "python",
        "treesitter": "python",
        "lsp": {
            "config": "pyright",
            "clients": ["pyright"],
        },
        "formatter": "ruff_format",
        "linters": ["ruff", "mypy"],
        "dap": {
            "adapter": "python",
            "filetype": "python",
            "package": "debugpy",
        },
    },
    "C": {
        "filename": "audit_c.c",
        "filetype": "c",
        "treesitter": "c",
        "lsp": {
            "config": "clangd",
            "clients": ["clangd"],
        },
        "formatter": "clang_format",
        "linters": ["clangtidy"],
        "dap": {
            "adapter": "codelldb",
            "filetype": "c",
            "package": "codelldb",
        },
    },
    "C++": {
        "filename": "audit_cpp.cpp",
        "filetype": "cpp",
        "treesitter": "cpp",
        "lsp": {
            "config": "clangd",
            "clients": ["clangd"],
        },
        "formatter": "clang_format",
        "linters": ["clangtidy"],
        "dap": {
            "adapter": "codelldb",
            "filetype": "cpp",
            "package": "codelldb",
        },
    },
    "Rust": {
        "filename": "audit_rust.rs",
        "filetype": "rust",
        "treesitter": "rust",
        "lsp": {
            "config": "rust_analyzer",
            "clients": ["rust_analyzer", "rust-analyzer"],
        },
        "formatter": "rustfmt",
        "linters": ["clippy"],
        "dap": {
            "adapter": "codelldb",
            "filetype": "rust",
            "package": "codelldb",
        },
    },
    "Go": {
        "filename": "audit_go.go",
        "filetype": "go",
        "treesitter": "go",
        "lsp": {
            "config": "gopls",
            "clients": ["gopls"],
        },
        "formatter": "gofumpt",
        "linters": ["golangcilint"],
        "dap": {
            "adapter": "delve",
            "filetype": "go",
            "package": "delve",
        },
    },
    "Shell": {
        "filename": "audit_shell.sh",
        "filetype": "sh",
        "treesitter": "bash",
        "lsp": {
            "config": "bashls",
            "clients": ["bashls", "bash-language-server"],
        },
        "formatter": "shfmt",
        "linters": ["shellcheck"],
        "dap": {
            "adapter": "bash",
            "filetype": "sh",
            "package": "bash-debug-adapter",
        },
    },
    "Bash": {
        "filename": "audit_bash.bash",
        "filetype": "sh",
        "accepted_filetypes": ["sh", "bash"],
        "treesitter": "bash",
        "lsp": {
            "config": "bashls",
            "clients": ["bashls", "bash-language-server"],
        },
        "formatter": "shfmt",
        "linters": ["shellcheck"],
        "dap": {
            "adapter": "bash",
            "filetype": "sh",
            "package": "bash-debug-adapter",
        },
    },
    "Lua": {
        "filename": "audit_lua.lua",
        "filetype": "lua",
        "treesitter": "lua",
        "lsp": {
            "config": "lua_ls",
            "clients": ["lua_ls", "lua-language-server"],
        },
        "formatter": "stylua",
        "linters": None,
        "dap": {
            "adapter": "nlua",
            "filetype": "lua",
            "package": None,
        },
    },
    "Batch": {
        "filename": "audit_batch.bat",
        "filetype": "dosbatch",
        "treesitter": None,
        "lsp": None,
        "formatter": None,
        "linters": None,
        "dap": None,
    },
    "CMD": {
        "filename": "audit_cmd.cmd",
        "filetype": "dosbatch",
        "treesitter": None,
        "lsp": None,
        "formatter": None,
        "linters": None,
        "dap": None,
    },
}


PLUGIN_MODULES = {
    "Mason": "mason",
    "Mason LSPConfig": "mason-lspconfig",
    "nvim-dap": "dap",
    "DAP UI": "dapui",
    "nvim-lint": "lint",
    "Conform": "conform",
    "Neotest": "neotest",
    "Neotest Python": "neotest-python",
    "Telescope": "telescope",
    "Which-Key": "which-key",
    "Indent Blankline": "ibl",
    "ToggleTerm": "toggleterm",
    "Plenary": "plenary",
    "nvim-cmp": "cmp",
    "LuaSnip": "luasnip",
    "Treesitter": "nvim-treesitter",
    "Trouble": "trouble",
}


KEYMAPS = {
    "<leader>f": "Format file",
    "<leader>tr": "Run nearest test",
    "<leader>tf": "Run current file tests",
    "<leader>ts": "Toggle test summary",
    "<leader>to": "Show test output",
    "K": "Show documentation",
    "<leader>r": "Reload theme",
}


# ============================================================================
# UI helpers
# ============================================================================


def status_symbol(state: str) -> str:
    return {
        "pass": "✅",
        "warn": "⚠️",
        "fail": "❌",
        "na": "—",
    }.get(state, "?")


def print_state(
    state: str,
    label: str,
    detail: str = "",
) -> None:
    suffix = f" — {detail}" if detail else ""
    print(f"{status_symbol(state)} {label}{suffix}")


# ============================================================================
# Lua probe
#
# Important:
# - No generated Lua code interpolation.
# - Config path is passed through an environment variable.
# - Every phase is isolated.
# - No LSP wait loop.
# - No DAP sessions are launched.
# - No Mason installation/update operations are performed.
# ============================================================================


LUA_PROBE = r"""
local RESULT_PREFIX = "__NEOVIM_AUDIT_RESULT__"

local result = {
    environment = {},
    syntax = {},
    mason = {},
    plugins = {},
    colorscheme = {},
    keymaps = {},
    filetypes = {},
    treesitter = {},
    lsp = {},
    formatters = {},
    linters = {},
    dap = {},
    errors = {},
}

local CONFIG_DIR = os.getenv("NVIM_AUDIT_CONFIG")


local function emit()
    local ok, payload = pcall(
        vim.json.encode,
        result
    )

    if ok then
        print(
            RESULT_PREFIX .. payload
        )
    else
        print(
            RESULT_PREFIX
            .. vim.json.encode({
                errors = {
                    {
                        phase = "emit",
                        detail = tostring(payload),
                    },
                },
            })
        )
    end
end


local function phase(name, fn)
    local ok, err = xpcall(
        fn,
        debug.traceback
    )

    if not ok then
        table.insert(
            result.errors,
            {
                phase = name,
                detail = tostring(err),
            }
        )
    end
end


local function executable(name)
    if not name or name == "" then
        return ""
    end

    local ok, path = pcall(
        vim.fn.exepath,
        name
    )

    if ok and path and path ~= "" then
        return path
    end

    return ""
end


local function command_name(command)
    if type(command) == "string" then
        return command
    end

    if type(command) == "table" then
        return command[1]
    end

    return nil
end


local function contains(list, value)
    for _, item in ipairs(list or {}) do
        if item == value then
            return true
        end
    end

    return false
end


local function client_matches(name, accepted)
    return contains(
        accepted,
        name
    )
end


local function safe_require(name)
    return pcall(
        require,
        name
    )
end


local function get_or_empty(value)
    if type(value) == "table" then
        return value
    end

    return {}
end


-- ==========================================================================
-- LANGUAGE DEFINITIONS
-- ==========================================================================

local languages = {
    Python = {
        filename = "audit_python.py",
        filetype = "python",
        treesitter = "python",

        lsp = {
            config = "pyright",
            clients = { "pyright" },
        },

        formatter = "ruff_format",

        linters = {
            "ruff",
            "mypy",
        },

        dap = {
            adapter = "python",
            filetype = "python",
            package = "debugpy",
        },
    },

    C = {
        filename = "audit_c.c",
        filetype = "c",
        treesitter = "c",

        lsp = {
            config = "clangd",
            clients = { "clangd" },
        },

        formatter = "clang_format",

        linters = {
            "clangtidy",
        },

        dap = {
            adapter = "codelldb",
            filetype = "c",
            package = "codelldb",
        },
    },

    ["C++"] = {
        filename = "audit_cpp.cpp",
        filetype = "cpp",
        treesitter = "cpp",

        lsp = {
            config = "clangd",
            clients = { "clangd" },
        },

        formatter = "clang_format",

        linters = {
            "clangtidy",
        },

        dap = {
            adapter = "codelldb",
            filetype = "cpp",
            package = "codelldb",
        },
    },

    Rust = {
        filename = "audit_rust.rs",
        filetype = "rust",
        treesitter = "rust",

        lsp = {
            config = "rust_analyzer",
            clients = {
                "rust_analyzer",
                "rust-analyzer",
            },
        },

        formatter = "rustfmt",

        linters = {
            "clippy",
        },

        dap = {
            adapter = "codelldb",
            filetype = "rust",
            package = "codelldb",
        },
    },

    Go = {
        filename = "audit_go.go",
        filetype = "go",
        treesitter = "go",

        lsp = {
            config = "gopls",
            clients = { "gopls" },
        },

        formatter = "gofumpt",

        linters = {
            "golangcilint",
        },

        dap = {
            adapter = "delve",
            filetype = "go",
            package = "delve",
        },
    },

    Shell = {
        filename = "audit_shell.sh",
        filetype = "sh",
        treesitter = "bash",

        lsp = {
            config = "bashls",
            clients = {
                "bashls",
                "bash-language-server",
            },
        },

        formatter = "shfmt",

        linters = {
            "shellcheck",
        },

        dap = {
            adapter = "bash",
            filetype = "sh",
            package = "bash-debug-adapter",
        },
    },

    Bash = {
        filename = "audit_bash.bash",
        filetype = "sh",

        accepted_filetypes = {
            "sh",
            "bash",
        },

        treesitter = "bash",

        lsp = {
            config = "bashls",
            clients = {
                "bashls",
                "bash-language-server",
            },
        },

        formatter = "shfmt",

        linters = {
            "shellcheck",
        },

        dap = {
            adapter = "bash",
            filetype = "sh",
            package = "bash-debug-adapter",
        },
    },

    Lua = {
        filename = "audit_lua.lua",
        filetype = "lua",
        treesitter = "lua",

        lsp = {
            config = "lua_ls",
            clients = {
                "lua_ls",
                "lua-language-server",
            },
        },

        formatter = "stylua",

        linters = nil,

        dap = {
            adapter = "nlua",
            filetype = "lua",
            package = nil,
        },
    },

    Batch = {
        filename = "audit_batch.bat",
        filetype = "dosbatch",
        treesitter = nil,
        lsp = nil,
        formatter = nil,
        linters = nil,
        dap = nil,
    },

    CMD = {
        filename = "audit_cmd.cmd",
        filetype = "dosbatch",
        treesitter = nil,
        lsp = nil,
        formatter = nil,
        linters = nil,
        dap = nil,
    },
}


-- ==========================================================================
-- ENVIRONMENT
-- ==========================================================================

phase("environment", function()
    local version = vim.version()

    result.environment.nvim_version = string.format(
        "%d.%d.%d",
        version.major,
        version.minor,
        version.patch
    )

    result.environment.nvim_path = vim.env.PATH or ""

    result.environment.mason_root =
        vim.fn.stdpath("data") .. "/mason"

    result.environment.mason_bin =
        vim.fn.stdpath("data") .. "/mason/bin"

    result.environment.mason_bin_in_path =
        string.find(
            result.environment.nvim_path,
            result.environment.mason_bin,
            1,
            true
        ) ~= nil
end)


-- ==========================================================================
-- LUA SYNTAX
-- ==========================================================================

phase("lua syntax", function()
    local files = vim.fs.find(
        function(name)
            return name:sub(-4) == ".lua"
        end,
        {
            path = CONFIG_DIR,
            type = "file",
            limit = math.huge,
        }
    )

    for _, path in ipairs(files) do
        local chunk, err =
            loadfile(path)

        local relative =
            vim.fn.fnamemodify(
                path,
                ":."
            )

        if chunk then
            table.insert(
                result.syntax,
                {
                    state = "pass",
                    file = relative,
                }
            )
        else
            table.insert(
                result.syntax,
                {
                    state = "fail",
                    file = relative,
                    detail = tostring(err),
                }
            )
        end
    end
end)


-- ==========================================================================
-- MASON
-- ==========================================================================

phase("mason", function()
    local ok_mason, mason =
        safe_require("mason")

    if not ok_mason then
        result.mason.module = {
            state = "fail",
            detail = "Mason module unavailable",
        }

        return
    end

    result.mason.module = {
        state = "pass",
        detail = "loaded",
    }

    local setup_ok, setup_error =
        pcall(mason.setup)

    if not setup_ok then
        result.mason.module = {
            state = "fail",
            detail = tostring(setup_error),
        }

        return
    end

    local ok_registry, registry =
        safe_require("mason-registry")

    if not ok_registry then
        result.mason.registry = {
            state = "fail",
            detail =
                "mason-registry unavailable",
        }

        return
    end

    local packages = {
        "pyright",
        "clangd",
        "rust-analyzer",
        "gopls",
        "bash-language-server",
        "lua-language-server",

        "ruff",
        "mypy",
        "clang-format",
        "gofumpt",
        "shfmt",
        "stylua",

        "clang-tidy",
        "golangci-lint",
        "shellcheck",

        "debugpy",
        "codelldb",
        "delve",
        "bash-debug-adapter",
    }

    for _, name in ipairs(packages) do
        local has_package = false

        pcall(function()
            has_package =
                registry.has_package(name)
        end)

        if not has_package then
            result.mason[name] = {
                state = "warn",
                detail =
                    "not present in Mason registry",
            }
        else
            local installed = false

            pcall(function()
                installed =
                    registry.is_installed(name)
            end)

            result.mason[name] = {
                state =
                    installed
                    and "pass"
                    or "warn",

                installed = installed,

                detail =
                    installed
                    and "installed"
                    or "not installed",
            }
        end
    end
end)


-- ==========================================================================
-- PLUGINS
-- ==========================================================================

phase("plugins", function()
    local checks = {
        { "Mason", "mason" },
        { "Mason LSPConfig", "mason-lspconfig" },
        { "nvim-dap", "dap" },
        { "DAP UI", "dapui" },
        { "nvim-lint", "lint" },
        { "Conform", "conform" },
        { "Neotest", "neotest" },
        { "Neotest Python", "neotest-python" },
        { "Telescope", "telescope" },
        { "Which-Key", "which-key" },
        { "Indent Blankline", "ibl" },
        { "ToggleTerm", "toggleterm" },
        { "Plenary", "plenary" },
        { "nvim-cmp", "cmp" },
        { "LuaSnip", "luasnip" },
        { "Treesitter", "nvim-treesitter" },
        { "Trouble", "trouble" },
    }

    for _, item in ipairs(checks) do
        local ok =
            pcall(require, item[2])

        result.plugins[item[1]] = {
            state = ok
                and "pass"
                or "warn",

            detail = ok
                and "available"
                or "module unavailable",
        }
    end
end)


-- ==========================================================================
-- COLORSCHEME
-- ==========================================================================

phase("colorscheme", function()
    local name =
        vim.g.colors_name or ""

    result.colorscheme = {
        state =
            name == "mytheme"
            and "pass"
            or "fail",

        name =
            name ~= ""
            and name
            or "<none>",

        detail =
            name == "mytheme"
            and ""
            or "mytheme is not active",
    }
end)


-- ==========================================================================
-- KEYMAPS
-- ==========================================================================

phase("keymaps", function()
    local mappings = {
        ["<leader>f"] = "Format file",
        ["<leader>tr"] = "Run nearest test",
        ["<leader>tf"] = "Run current file tests",
        ["<leader>ts"] = "Toggle test summary",
        ["<leader>to"] = "Show test output",
        ["K"] = "Show documentation",
        ["<leader>r"] = "Reload theme",
    }

    for lhs, description in pairs(mappings) do
        local ok, maps =
            pcall(
                vim.keymap.get,
                "n",
                lhs
            )

        if ok and #maps > 0 then
            result.keymaps[lhs] = {
                state = "pass",
                detail = description,
            }
        else
            result.keymaps[lhs] = {
                state = "warn",
                detail =
                    "not visible during audit startup",
            }
        end
    end
end)


-- ==========================================================================
-- FILETYPES
-- ==========================================================================

phase("filetypes", function()
    for language, spec in
        pairs(languages)
    do
        local filename =
            CONFIG_DIR .. "/"
            .. spec.filename

        local detected =
            vim.filetype.match({
                filename = filename,
            })

        local accepted =
            spec.accepted_filetypes
            or { spec.filetype }

        if contains(
            accepted,
            detected
        ) then
            result.filetypes[language] = {
                state = "pass",
                detected = detected,
            }
        else
            result.filetypes[language] = {
                state = "fail",
                detected =
                    detected or "<none>",
            }
        end
    end
end)


-- ==========================================================================
-- TREE-SITTER
-- ==========================================================================

phase("treesitter", function()
    local ok_ts = pcall(
        require,
        "nvim-treesitter"
    )

    for language, spec in pairs(languages) do
        if not spec.treesitter then
            result.treesitter[language] = {
                state = "na",
                detail = "no native parser configured",
            }
        elseif not ok_ts then
            result.treesitter[language] = {
                state = "fail",
                parser = spec.treesitter,
                detail = "nvim-treesitter unavailable",
            }
        else
            local parser_available = false

            pcall(function()
                parser_available =
                    vim.treesitter.language.add(
                        spec.treesitter
                    )
            end)

            if parser_available then
                result.treesitter[language] = {
                    state = "pass",
                    parser = spec.treesitter,
                }
            else
                result.treesitter[language] = {
                    state = "warn",
                    parser = spec.treesitter,
                    detail =
                        "parser could not be loaded",
                }
            end
        end
    end
end)


-- ==========================================================================
-- LSP
--
-- This intentionally checks the real configuration rather than waiting for
-- asynchronous client attachment.
--
-- A configured + enabled LSP is PASS.
-- A disabled/missing LSP configuration is FAIL.
-- ==========================================================================

phase("lsp", function()
    for language, spec in
        pairs(languages)
    do
        if not spec.lsp then
            result.lsp[language] = {
                state = "na",
                detail =
                    "no native LSP configured",
            }
        else
            local config =
                spec.lsp.config

            local enabled = false

            local enabled_ok, enabled_value =
                pcall(
                    vim.lsp.is_enabled,
                    config
                )

            if enabled_ok then
                enabled = enabled_value
            end

            if not enabled then
                result.lsp[language] = {
                    state = "fail",
                    config = config,
                    detail =
                        "LSP configuration is not enabled",
                }
            else
                local client_present = false

                for _, client in ipairs(
                    vim.lsp.get_clients()
                ) do
                    if client_matches(
                        client.name,
                        spec.lsp.clients
                    ) then
                        client_present = true
                        break
                    end
                end

                result.lsp[language] = {
                    state = "pass",
                    config = config,
                    detail =
                        client_present
                        and "enabled; client active"
                        or "enabled; no client active in audit session",
                }
            end
        end
    end
end)


-- ==========================================================================
-- FORMATTERS
-- ==========================================================================

phase("formatters", function()
    local ok, conform =
        safe_require("conform")

    for language, spec in
        pairs(languages)
    do
        if not spec.formatter then
            result.formatters[language] = {
                state = "na",
                detail =
                    "no native formatter configured",
            }
        elseif not ok then
            result.formatters[language] = {
                state = "fail",
                formatter = spec.formatter,
                detail =
                    "Conform unavailable",
            }
        else
            local info_ok, info =
                pcall(
                    conform.get_formatter_info,
                    spec.formatter,
                    0
                )

            if not info_ok then
                result.formatters[language] = {
                    state = "fail",
                    formatter = spec.formatter,
                    detail = tostring(info),
                }
            elseif info.available then
                result.formatters[language] = {
                    state = "pass",
                    formatter = spec.formatter,
                }
            else
                result.formatters[language] = {
                    state = "warn",
                    formatter = spec.formatter,
                    detail =
                        info.available_msg
                        or "formatter unavailable",
                }
            end
        end
    end
end)


-- ==========================================================================
-- LINTERS
-- ==========================================================================

phase("linters", function()
    local ok, lint =
        safe_require("lint")

    for language, spec in
        pairs(languages)
    do
        if not spec.linters then
            result.linters[language] = {
                state = "na",
                detail =
                    "no native/current linter configured",
            }
        elseif not ok then
            result.linters[language] = {
                state = "fail",
                detail =
                    "nvim-lint unavailable",
            }
        else
            local configured =
                lint.linters_by_ft[
                    spec.filetype
                ]

            if not configured then
                result.linters[language] = {
                    state = "fail",
                    detail =
                        "filetype has no nvim-lint configuration",
                }
            else
                local details = {}
                local overall = "pass"

                for _, name in ipairs(
                    spec.linters
                ) do
                    local linter =
                        lint.linters[name]

                    if not linter then
                        table.insert(
                            details,
                            {
                                name = name,
                                state = "fail",
                                detail =
                                    "unknown nvim-lint linter",
                            }
                        )

                        overall = "fail"
                    else
                        local resolved =
                            linter

                        if type(linter) ==
                            "function"
                        then
                            local resolve_ok, value =
                                pcall(linter)

                            if resolve_ok then
                                resolved = value
                            else
                                table.insert(
                                    details,
                                    {
                                        name = name,
                                        state = "fail",
                                        detail =
                                            tostring(value),
                                    }
                                )

                                overall = "fail"
                                resolved = nil
                            end
                        end

                        if resolved then
                            local command =
                                command_name(
                                    resolved.cmd
                                )

                            local path =
                                executable(command)

                            if path ~= "" then
                                table.insert(
                                    details,
                                    {
                                        name = name,
                                        state = "pass",
                                        path = path,
                                    }
                                )
                            else
                                table.insert(
                                    details,
                                    {
                                        name = name,
                                        state = "warn",
                                        detail =
                                            "executable unavailable in Neovim PATH",
                                    }
                                )

                                if overall ==
                                    "pass"
                                then
                                    overall = "warn"
                                end
                            end
                        end
                    end
                end

                result.linters[language] = {
                    state = overall,
                    details = details,
                }
            end
        end
    end
end)


-- ==========================================================================
-- DAP
-- ==========================================================================

phase("dap", function()
    local ok, dap =
        safe_require("dap")

    for language, spec in
        pairs(languages)
    do
        if not spec.dap then
            result.dap[language] = {
                state = "na",
                detail =
                    "no native/current DAP configured",
            }
        elseif not ok then
            result.dap[language] = {
                state = "fail",
                detail =
                    "nvim-dap unavailable",
            }
        else
            local adapter =
                dap.adapters[
                    spec.dap.adapter
                ]

            local configs =
                dap.configurations[
                    spec.dap.filetype
                ]

            configs =
                get_or_empty(configs)

            local has_config =
                #configs > 0

            if adapter and has_config then
                result.dap[language] = {
                    state = "pass",
                    adapter =
                        spec.dap.adapter,
                }
            elseif spec.dap.package then
                local installed = false

                pcall(function()
                    local registry =
                        require("mason-registry")

                    installed =
                        registry.is_installed(
                            spec.dap.package
                        )
                end)

                if installed then
                    result.dap[language] = {
                        state = "warn",
                        adapter =
                            spec.dap.adapter,
                        detail =
                            "debugger installed, but adapter/configuration is incomplete",
                    }
                else
                    result.dap[language] = {
                        state = "warn",
                        adapter =
                            spec.dap.adapter,
                        detail =
                            "debugger unavailable",
                    }
                end
            else
                result.dap[language] = {
                    state = "warn",
                    adapter =
                        spec.dap.adapter,
                    detail =
                        "adapter/configuration incomplete",
                }
            end
        end
    end
end)


-- ==========================================================================
-- EMIT + EXIT
-- ==========================================================================

emit()

vim.schedule(function()
    pcall(
        vim.cmd,
        "qa!"
    )
end)
"""


# ============================================================================
# Execute Neovim
# ============================================================================


def run_nvim(
    nvim: str,
) -> tuple[dict[str, Any] | None, str, int]:
    with tempfile.TemporaryDirectory(prefix="nvim-audit-") as temp_dir:
        probe_path = Path(temp_dir) / "probe.lua"

        probe_path.write_text(
            LUA_PROBE,
            encoding="utf-8",
        )

        env = os.environ.copy()
        env["NVIM_AUDIT_CONFIG"] = str(CONFIG_DIR)

        command = [
            nvim,
            "--headless",
            "-u",
            str(INIT_LUA),
            "-l",
            str(probe_path),
        ]

        try:
            process = subprocess.run(
                command,
                text=True,
                capture_output=True,
                timeout=NVIM_TIMEOUT,
                env=env,
                check=False,
            )
        except subprocess.TimeoutExpired as exc:
            stdout = exc.stdout or ""
            stderr = exc.stderr or ""

            if isinstance(stdout, bytes):
                stdout = stdout.decode(errors="replace")

            if isinstance(stderr, bytes):
                stderr = stderr.decode(errors="replace")

            return (
                None,
                stdout + "\n" + stderr,
                124,
            )

        combined = process.stdout + "\n" + process.stderr

        marker = combined.rfind(RESULT_PREFIX)

        if marker < 0:
            return (
                None,
                combined,
                process.returncode,
            )

        payload = combined[marker + len(RESULT_PREFIX) :]

        lines = payload.splitlines()

        if not lines:
            return (
                None,
                combined,
                process.returncode,
            )

        json_line = lines[0].strip()

        try:
            result = json.loads(json_line)
        except json.JSONDecodeError:
            return (
                None,
                combined,
                process.returncode,
            )

        return (
            result,
            combined,
            process.returncode,
        )


# ============================================================================
# Report
# ============================================================================


def print_report(
    result: dict[str, Any],
) -> None:
    print()
    print("=" * 60)
    print("                 NEOVIM FULL AUDIT")
    print("=" * 60)

    env = result.get(
        "environment",
        {},
    )

    print()
    print(f"Config: {CONFIG_DIR}")
    print(f"Neovim: {env.get('nvim_version', 'unknown')}")

    mason_path_state = "pass" if env.get("mason_bin_in_path") else "warn"

    mason_path_detail = (
        "Mason bin is in the Neovim PATH"
        if env.get("mason_bin_in_path")
        else "Mason bin is not in the Neovim PATH"
    )

    print_state(
        mason_path_state,
        "Mason PATH",
        mason_path_detail,
    )

    # ------------------------------------------------------------------------
    # Syntax
    # ------------------------------------------------------------------------

    print()
    print("=== CONFIGURATION SYNTAX ===")

    syntax = result.get(
        "syntax",
        [],
    )

    failures = [item for item in syntax if item.get("state") == "fail"]

    if failures:
        for item in failures:
            print_state(
                "fail",
                item.get(
                    "file",
                    "<unknown>",
                ),
                item.get(
                    "detail",
                    "",
                ),
            )
    else:
        print_state(
            "pass",
            f"All Lua files compile ({len(syntax)} files)",
        )

    # ------------------------------------------------------------------------
    # Mason
    # ------------------------------------------------------------------------

    print()
    print("=== MASON ===")

    mason = result.get(
        "mason",
        {},
    )

    module = mason.get("module")

    if isinstance(module, dict):
        print_state(
            module.get(
                "state",
                "fail",
            ),
            "Mason",
            module.get(
                "detail",
                "",
            ),
        )

    for name in sorted(mason):
        if name in {
            "module",
            "registry",
        }:
            continue

        item = mason[name]

        if isinstance(item, dict):
            print_state(
                item.get(
                    "state",
                    "warn",
                ),
                name,
                item.get(
                    "detail",
                    "",
                ),
            )

    # ------------------------------------------------------------------------
    # Plugins
    # ------------------------------------------------------------------------

    print()
    print("=== PLUGINS ===")

    for name in sorted(
        result.get(
            "plugins",
            {},
        )
    ):
        item = result["plugins"][name]

        print_state(
            item.get(
                "state",
                "warn",
            ),
            name,
            item.get(
                "detail",
                "",
            ),
        )

    # ------------------------------------------------------------------------
    # Colorscheme
    # ------------------------------------------------------------------------

    print()
    print("=== COLORSCHEME ===")

    colorscheme = result.get(
        "colorscheme",
        {},
    )

    print_state(
        colorscheme.get(
            "state",
            "fail",
        ),
        (
            "Colorscheme — "
            + str(
                colorscheme.get(
                    "name",
                    "<none>",
                )
            )
        ),
        colorscheme.get(
            "detail",
            "",
        ),
    )

    # ------------------------------------------------------------------------
    # Keymaps
    # ------------------------------------------------------------------------

    print()
    print("=== KEYMAPS ===")

    for lhs in KEYMAPS:
        item = result.get(
            "keymaps",
            {},
        ).get(
            lhs,
            {},
        )

        print_state(
            item.get(
                "state",
                "warn",
            ),
            lhs,
            item.get(
                "detail",
                "",
            ),
        )

    # ------------------------------------------------------------------------
    # Languages
    # ------------------------------------------------------------------------

    counts = {
        "pass": 0,
        "warn": 0,
        "fail": 0,
        "na": 0,
    }

    sections = [
        ("Filetype", "filetypes"),
        ("Treesitter", "treesitter"),
        ("LSP", "lsp"),
        ("Formatter", "formatters"),
    ]

    for language in LANGUAGES:
        print()
        print(language)

        for label, section in sections:
            item = result.get(
                section,
                {},
            ).get(
                language,
                {},
            )

            state = item.get(
                "state",
                "fail",
            )

            if label == "Filetype":
                detail = "detected " + str(
                    item.get(
                        "detected",
                        "<none>",
                    )
                )
            elif label == "Treesitter":
                detail = item.get("parser") or item.get(
                    "detail",
                    "",
                )
            elif label == "LSP":
                detail = item.get("config") or item.get(
                    "detail",
                    "",
                )
            else:
                detail = item.get("formatter") or item.get(
                    "detail",
                    "",
                )

            print_state(
                state,
                label,
                detail,
            )

            counts[state] += 1

        lint = result.get(
            "linters",
            {},
        ).get(
            language,
            {},
        )

        lint_state = lint.get(
            "state",
            "fail",
        )

        print_state(
            lint_state,
            "Lint",
        )

        counts[lint_state] += 1

        for detail_item in lint.get(
            "details",
            [],
        ):
            print_state(
                detail_item.get(
                    "state",
                    "warn",
                ),
                (
                    "    "
                    + detail_item.get(
                        "name",
                        "unknown",
                    )
                ),
                detail_item.get("detail")
                or detail_item.get(
                    "path",
                    "",
                ),
            )

        dap = result.get(
            "dap",
            {},
        ).get(
            language,
            {},
        )

        dap_state = dap.get(
            "state",
            "na",
        )

        print_state(
            dap_state,
            "DAP",
            (
                dap.get("adapter")
                or dap.get(
                    "detail",
                    "",
                )
            ),
        )

        counts[dap_state] += 1

    # ------------------------------------------------------------------------
    # Auditor
    # ------------------------------------------------------------------------

    errors = result.get(
        "errors",
        [],
    )

    if errors:
        print()
        print("=== AUDITOR ===")

        for error in errors:
            print_state(
                "warn",
                error.get(
                    "phase",
                    "unknown",
                ),
                error.get(
                    "detail",
                    "",
                ),
            )

    # ------------------------------------------------------------------------
    # Summary
    # ------------------------------------------------------------------------

    print()
    print("=== RESULT ===")

    print_state(
        "pass",
        f"Working: {counts['pass']}",
    )

    print_state(
        "warn",
        f"Warnings: {counts['warn']}",
    )

    print_state(
        "fail",
        f"Broken: {counts['fail']}",
    )

    print_state(
        "na",
        f"Not applicable: {counts['na']}",
    )


# ============================================================================
# Main
# ============================================================================


def main() -> int:
    if not CONFIG_DIR.is_dir():
        print(
            f"ERROR: config not found: {CONFIG_DIR}",
            file=sys.stderr,
        )
        return 1

    if not INIT_LUA.is_file():
        print(
            f"ERROR: init.lua not found: {INIT_LUA}",
            file=sys.stderr,
        )
        return 1

    nvim = shutil.which("nvim")

    if not nvim:
        print(
            "ERROR: nvim not found in PATH",
            file=sys.stderr,
        )
        return 1

    result, output, returncode = run_nvim(nvim)

    if result is None:
        print()
        print("NEOVIM AUDIT COULD NOT BE COMPLETED")
        print()

        if output.strip():
            print(output)

        return returncode or 1

    print_report(result)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
