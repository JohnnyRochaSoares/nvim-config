return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPost", "BufWritePost" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                python = { "ruff", "mypy" },
            }

            lint.linters.mypy = vim.tbl_deep_extend("force", lint.linters.mypy, {
                args = {
                    "--ignore-missing-imports",
                    "--show-column-numbers",
                },
            })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
                callback = function()
                    if vim.fn.filereadable(vim.api.nvim_buf_get_name(0)) == 1 then
                        lint.try_lint()
                    end
                end,
            })
        end,
    },
}
