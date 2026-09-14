return {
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },

        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Python
            vim.lsp.config("pyright", {
                capabilities = capabilities,

                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace",
                        },
                    },
                },
            })

            vim.lsp.enable("pyright")

            -- C / C++
            vim.lsp.config("clangd", {
                capabilities = capabilities,
            })

            vim.lsp.enable("clangd")

            -- Rust
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
            })

            vim.lsp.enable("rust_analyzer")

            -- Go
            vim.lsp.config("gopls", {
                capabilities = capabilities,
            })

            vim.lsp.enable("gopls")

            -- Shell / Bash
            vim.lsp.config("bashls", {
                capabilities = capabilities,
            })

            vim.lsp.enable("bashls")

            -- Lua
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,

                settings = {
                    Lua = {
                        runtime = {
                            version = "LuaJIT",
                        },

                        diagnostics = {
                            globals = {
                                "vim",
                            },
                        },

                        workspace = {
                            checkThirdParty = false,
                            library = vim.api.nvim_get_runtime_file("", true),
                        },

                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            vim.lsp.enable("lua_ls")

            vim.keymap.set(
                "n",
                "K",
                vim.lsp.buf.hover,
                { desc = "Show documentation" }
            )

            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●",
                },

                signs = true,
                underline = true,
                update_in_insert = false,

                float = {
                    border = "rounded",
                    source = "always",
                },
            })
        end,
    },
}
