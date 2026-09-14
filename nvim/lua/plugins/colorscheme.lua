return {
    {
        name = "mytheme",
        dir = vim.fn.stdpath("config"),
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("mytheme")
            vim.opt.number = true

            vim.opt.cursorline = true

            vim.api.nvim_set_hl(0, "LineNr", {
                fg = "#999999",
            })

            vim.api.nvim_set_hl(0, "CursorLineNr", {
                fg = "#fff700",
                bold = true,
            })

            vim.api.nvim_set_hl(0, "CursorLine", {
                bg = "#595959",
            })
        end,
    },
}
