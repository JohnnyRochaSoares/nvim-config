return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",

        init = function()
            vim.g.terminal_color_0 = "#14191E"
            vim.g.terminal_color_1 = "#B43C2A"
            vim.g.terminal_color_2 = "#00C200"
            vim.g.terminal_color_3 = "#C7C400"
            vim.g.terminal_color_4 = "#2744C7"
            vim.g.terminal_color_5 = "#C040BE"
            vim.g.terminal_color_6 = "#00C5C7"
            vim.g.terminal_color_7 = "#C7C7C7"
            vim.g.terminal_color_8 = "#686868"
            vim.g.terminal_color_9 = "#DD7975"
            vim.g.terminal_color_10 = "#58E790"
            vim.g.terminal_color_11 = "#ECE100"
            vim.g.terminal_color_12 = "#A7ABF2"
            vim.g.terminal_color_13 = "#E17EE1"
            vim.g.terminal_color_14 = "#60FDFF"
            vim.g.terminal_color_15 = "#FFFFFF"
        end,

        opts = {
            shell = "/bin/zsh -i",
            direction = "float",
            shade_terminals = false,

            highlights = {
                Normal = {
                    guibg = "#000000",
                },
                NormalFloat = {
                    guibg = "#000000",
                },
                FloatBorder = {
                    guifg = "#686868",
                    guibg = "#000000",
                },
            },

            float_opts = {
                border = "rounded",
                winblend = 0,
            },
        },

        keys = {
            {
                "<leader>k",
                "<cmd>ToggleTerm<cr>",
                desc = "Toggle terminal",
            },
        },
    },
}
