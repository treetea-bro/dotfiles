return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
			},
			formatters = {
				prettier = {
					prepend_args = { "--print-width", "80" },
				},
			},
		},
	},
}
