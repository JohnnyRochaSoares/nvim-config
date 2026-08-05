return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "ruff" },
                },
                format_on_save = {
                    timeout_ms = 3000,
                    lsp_fallback = false,
                },
            })

            vim.keymap.set("n", "<leader>f", function()
                require("conform").format({ async = true })
            end, { desc = "Format file" })
        end,
    },
}
