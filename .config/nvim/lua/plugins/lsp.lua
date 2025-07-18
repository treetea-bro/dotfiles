return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			local configs = require("lspconfig.configs")
			if not configs.pyrefly then
				configs.pyrefly = {
					default_config = {
						cmd = { "pyrefly", "lsp" },
						filetypes = { "python" },
						root_dir = require("lspconfig.util").root_pattern("pyproject.toml"),
						settings = {},
						single_file_support = true,
					},
				}
			end

			opts.servers = opts.servers or {}
			opts.servers.pyrefly = {}

			opts.servers.vtsls = {
				settings = {
					typescript = {
						tsserver = {
							pluginPaths = { "./node_modules" },
						},
					},
					vtsls = {
						autoUseWorkspaceTsdk = true,
						tsserver = {
							globalPlugins = {
								{
									name = "@effect/language-service",
									location = "./node_modules/@effect/language-service",
									enableForWorkspaceTypeScriptVersions = true,
								},
							},
						},
					},
				},
			}

			return opts
		end,
	},
}
