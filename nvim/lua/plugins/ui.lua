return {
    -- Mason: installs black, ruff, mypy
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        opts = {},
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
