return {
    {
        "nvim-telescope/telescope.nvim",
        version = "*",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            require("telescope").load_extension("fzf")
        end,
        keys = {
            {
                "<C-p>",
                function()
                    require("telescope.builtin").find_files()
                end,
                desc = "Find files",
            },
            {
                "<C-b>",
                function()
                    require("telescope.builtin").buffers()
                end,
                desc = "List buffers",
            },
            {
                "<leader>sg",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Search project text",
            },
            {
                "<leader>sd",
                function()
                    require("telescope.builtin").lsp_document_symbols()
                end,
                desc = "Document symbols",
            },
            {
                "<leader>sw",
                function()
                    require("telescope.builtin").lsp_workspace_symbols()
                end,
                desc = "Workspace symbols",
            },
            {
                "<leader>sr",
                function()
                    require("telescope.builtin").lsp_references()
                end,
                desc = "Symbol references",
            },
        },
    },
}
