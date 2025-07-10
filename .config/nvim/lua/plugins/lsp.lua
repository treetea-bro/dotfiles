return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				vtsls = {
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
				},
			},
		},
	},
}
