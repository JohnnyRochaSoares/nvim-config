return {
    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },

        opts = {
            ensure_installed = {
                "pyright",
                "clangd",
                "rust_analyzer",
                "gopls",
                "bashls",
                "lua_ls",
            },

            automatic_enable = false,
        },
    },
}
