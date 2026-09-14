return {
    {
        "mfussenegger/nvim-lint",

        event = {
            "BufReadPost",
            "BufWritePost",
        },

        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                python = {
                    "ruff",
                    "mypy",
                },

                c = {
                    "clangtidy",
                },

                cpp = {
                    "clangtidy",
                },

                rust = {
                    "clippy",
                },

                go = {
                    "golangcilint",
                },

                sh = {
                    "shellcheck",
                },

                bash = {
                    "shellcheck",
                },
            }

            if lint.linters.mypy then
                lint.linters.mypy = vim.tbl_deep_extend(
                    "force",
                    lint.linters.mypy,
                    {
                        args = {
                            "--ignore-missing-imports",
                            "--show-column-numbers",
                        },
                    }
                )
            end

            local executable_by_linter = {
                ruff = "ruff",
                mypy = "mypy",
                clangtidy = "clang-tidy",
                clippy = "cargo",
                golangcilint = "golangci-lint",
                shellcheck = "shellcheck",
            }

            local function try_lint()
                local ft = vim.bo.filetype
                local linters = lint.linters_by_ft[ft]

                if not linters then
                    return
                end

                local available = {}

                for _, name in ipairs(linters) do
                    local executable = executable_by_linter[name]

                    if executable == nil
                        or vim.fn.executable(executable) == 1
                    then
                        table.insert(available, name)
                    end
                end

                if #available > 0 then
                    lint.try_lint(available)
                end
            end

            vim.api.nvim_create_autocmd(
                {
                    "BufEnter",
                    "BufWritePost",
                    "InsertLeave",
                },
                {
                    callback = try_lint,
                }
            )
        end,
    },
}
