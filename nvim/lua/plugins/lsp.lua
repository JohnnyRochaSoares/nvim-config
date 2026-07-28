return {
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Pyright
            vim.lsp.config("pyright", {
                cmd = { "pyright-langserver", "--stdio" },
                root_markers = { "pyproject.toml", ".git" },
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

            -- Clangd
            vim.lsp.config("clangd", {
                cmd = { "clangd" },
                capabilities = capabilities,
            })
            vim.lsp.enable("clangd")

            -- Hover keymap
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })

            -- Diagnostics
            vim.diagnostic.config({
                virtual_text = { prefix = "●" },
                signs = true,
                underline = true,
                update_in_insert = false,
                float = { border = "rounded", source = "always" },
            })
        end,
    },
}
