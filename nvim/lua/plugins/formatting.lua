return {
    {
        "stevearc/conform.nvim",

        event = "BufWritePre",

        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = {
                        "ruff_format",
                    },

                    c = {
                        "clang_format",
                    },

                    cpp = {
                        "clang_format",
                    },

                    rust = {
                        "rustfmt",
                    },

                    go = {
                        "gofumpt",
                    },

                    sh = {
                        "shfmt",
                    },

                    bash = {
                        "shfmt",
                    },

                    lua = {
                        "stylua",
                    },
                },

                format_on_save = {
                    timeout_ms = 3000,
                    lsp_format = "fallback",
                },
            })

            vim.keymap.set(
                "n",
                "<leader>f",
                function()
                    require("conform").format({
                        async = true,
                        lsp_format = "fallback",
                    })
                end,
                {
                    desc = "Format file",
                }
            )
        end,
    },
}
