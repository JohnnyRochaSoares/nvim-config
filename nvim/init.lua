-- Options
vim.env.PATH =
    "/Users/joaorochasoares/Documents/Codex/superfile-local/bin:"
    .. (vim.env.PATH or "")

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup("plugins")

return {
    {
        name = "mytheme",
        dir = vim.fn.stdpath("config"),
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("mytheme")

            -- Reload theme with <leader>r
            vim.keymap.set("n", "<leader>r", function()
                vim.cmd("source " .. vim.fn.stdpath("config") .. "/colors/mytheme.lua")
            end, { desc = "Reload theme" })
        end,
    },
}
