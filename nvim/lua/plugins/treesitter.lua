return {
	{
		"nvim-treesitter/nvim-treesitter",

		lazy = false,

		build = ":TSUpdate",

		config = function()
			local treesitter = require("nvim-treesitter")

			------------------------------------------------------------------
			-- Standard parsers
			------------------------------------------------------------------

			treesitter.install({
				"python",
				"c",
				"cpp",
				"rust",
				"go",
				"bash",
				"lua",
			})

			vim.treesitter.language.register("batch", {
				"dosbatch",
			})

			------------------------------------------------------------------
			-- Custom Batch / CMD parser
			--
			-- tree-sitter-batch is an external grammar that supports both
			-- .bat and .cmd files.
			------------------------------------------------------------------

			vim.api.nvim_create_autocmd("User", {
				pattern = "TSUpdate",
				callback = function()
					require("nvim-treesitter.parsers").batch = {
						install_info = {
							url = "https://github.com/wharflab/tree-sitter-batch",
							branch = "main",
							queries = "queries",
						},

						tier = 2,
					}
				end,
			})

			------------------------------------------------------------------
			-- Register the parser for Neovim's dosbatch filetype.
			------------------------------------------------------------------

			vim.treesitter.language.register("batch", {
				"dosbatch",
			})

			------------------------------------------------------------------
			-- Enable Treesitter.
			------------------------------------------------------------------

			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"python",
					"c",
					"cpp",
					"rust",
					"go",
					"sh",
					"bash",
					"lua",
					"dosbatch",
				},

				callback = function()
					vim.treesitter.start()

					vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

					vim.wo.foldmethod = "expr"

					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
		end,
	},
}
