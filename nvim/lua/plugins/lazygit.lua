return {
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
            "LazyGitConfig",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        init = function()
            vim.g.lazygit_floating_window_border_chars = {
                "╭", "─", "╮", "│",
                "╯", "─", "╰", "│",
            }

            vim.g.lazygit_floating_window_use_plenary = 1
        end,
        keys = {
            {
                "<leader>git",
                "<cmd>LazyGit<cr>",
                desc = "Open LazyGit",
            },
            {
                "<leader>fgit",
                "<cmd>LazyGitCurrentFile<cr>",
                desc = "Open LazyGit for current file",
            },
        },
    },
}
