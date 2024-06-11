return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"selene",
				"luacheck",
				"shellcheck",
				"shfmt",
				"tailwindcss-language-server",
				"typescript-language-server",
				"prisma-language-server",
				"css-lsp",
				"debugpy",
				"js-debug-adapter",
				"node-debug2-adapter",
				"rust-analyzer",
			},
		},
	},
}
