return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",

        opts = {
            win = {
                wo = {
                    windblend = 0,
                    winhighlight = "Normal:WhichKeyNormal,FloatBorder:WhichKeyBorder",
                },
            },
        },

        config = function(_, opts)
            require("which-key").setup(opts)

            vim.opt.winblend = 0
            vim.opt.pumblend = 0

            vim.api.nvim_set_hl(0, "WhichKeyNormal", {
                fg = "#cdd6f4",
                bg = "#222222",
            })

            vim.api.nvim_set_hl(0, "WhichKeyBorder", {
                fg = "#555555",
                bg = "#222222",
            })

            -- Neovim completion popup
            vim.api.nvim_set_hl(0, "Pmenu", {
                fg = "#cdd6f4",
                bg = "#222222",
            })

            vim.api.nvim_set_hl(0, "PmenuSel", {
                fg = "#ffffff",
                bg = "#3a3a3a",
            })

            -- Floating documentation windows
            vim.api.nvim_set_hl(0, "NormalFloat", {
                fg = "#cdd6f4",
                bg = "#222222",
            })

            vim.api.nvim_set_hl(0, "FloatBorder", {
                fg = "#555555",
                bg = "#222222",
            })
        end,

        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = true })
                end,
                desc = "Show keybindings",
            },
        },
    },
}
