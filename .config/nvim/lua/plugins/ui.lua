return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"python",
				"rust",
				"typescript",
				"javascript",
				"json",
				"xml",
				"lua",
				"toml",
				"fish",
				"gitignore",
				"graphql",
				"http",
				"sql",
				"css",
				"regex",
				"bash",
				"markdown",
				"markdown_inline",
				"prisma",
				"groovy",
			},
		},
	},
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})

			opts.presets.lsp_doc_border = true
		end,
	},
}
