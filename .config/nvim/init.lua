-- =========================
-- Indentation
-- =========================
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- =========================
-- Lazy.nvim bootstrap
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/nvim-treesitter")

-- =========================
-- Plugins
-- =========================
require("lazy").setup({
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "folke/trouble.nvim", opts = {} },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && npm install",
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "lua",
                "vim",
                "markdown",
                "python",
                "bash",
                "c",
                "cpp",
                "cmake",
            },
            highlight = {
                enable = true,
            },
            indent = {
                enable = true,
            },
        },
    },

    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
})



-- =========================
-- Completion (nvim-cmp)
-- =========================
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        autocomplete = { require('cmp.types').cmp.TriggerEvent.TextChanged },
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
})

-- =========================
-- LSP (Pyright - Novo Padrão)
-- =========================
vim.lsp.config("pyright", {
    cmd = { "pyright-langserver", "--stdio" },
    root_markers = { "pyproject.toml", ".git" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            }
        }
    }
})

vim.lsp.enable("pyright")

-- =========================
-- LSP (Clangd)
-- =========================
vim.lsp.config("clangd", {
    cmd = { "clangd" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable("clangd")

-- Mapeamento para comportamento "Hover" (documentação da função)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Mostrar doc da função' })

-- =========================
-- Diagnostics (Avisos de erro)
-- =========================
vim.diagnostic.config({
    virtual_text = { prefix = '●' },
    signs = true,
    underline = true,
    update_in_insert = false,
    float = { border = "rounded", source = "always" },
})

-- =========================
-- Statusline
-- =========================
vim.opt.statusline = "%f %m %=%{v:lua.vim.diagnostic.count(0)[1] or 0}E %{v:lua.vim.diagnostic.count(0)[2] or 0}W"
