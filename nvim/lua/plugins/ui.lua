return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            require("mason").setup()

            require("mason-tool-installer").setup({
                ensure_installed = {
                    "pyright",
                    "clangd",
                    "ruff",
                    "mypy",
                },
                run_on_start = true, -- Garante que instala tudo ao abrir o Neovim
            })
        end,
    },

    -- Trouble: diagnostics panel
    {
        "folke/trouble.nvim",
        opts = {},
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && npm install",
    },
}
