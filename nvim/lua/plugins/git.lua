return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            on_attach = function(bufnr)
                local gitsigns = require("gitsigns")

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, {
                        buffer = bufnr,
                        desc = desc,
                    })
                end

                map("n", "]c", function()
                    gitsigns.nav_hunk("next")
                end, "Next Git hunk")

                map("n", "[c", function()
                    gitsigns.nav_hunk("prev")
                end, "Previous Git hunk")

                map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Git hunk")

                map("n", "<leader>hb", function()
                    gitsigns.blame_line({ full = true })
                end, "Blame current line")

                map("n", "<leader>hd", gitsigns.diffthis, "Show Git diff")

                map("n", "<leader>hs", gitsigns.stage_hunk, "Stage Git hunk")

                map("v", "<leader>hs", function()
                    gitsigns.stage_hunk({
                        vim.fn.line("."),
                        vim.fn.line("v"),
                    })
                end, "Stage selected hunk")
            end,
        },
    },
}
