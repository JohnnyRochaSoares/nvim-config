return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            vim.schedule(function()
                require("nvim-treesitter.config").setup({
                    highlight = { enable = true },
                    indent = { enable = true },
                    ensure_installed = {
                        "lua", "vim", "markdown",
                        "python", "bash", "c", "cpp",
                    },
                })
            end)
        end,
    },
}
