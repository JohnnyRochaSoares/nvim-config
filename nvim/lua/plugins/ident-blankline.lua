return {
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "│",
                highlight = "IblIndent",
            },
            scope = {
                enabled = true,
                char = "│",
                show_start = false,
                show_end = false,
                highlight = { "IblScope" },
            },
        },
        config = function(_, opts)
            require("ibl").setup(opts)

            -- Garante que o Treesitter arranca nos ficheiros de código
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "python", "lua", "c" },
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
}
