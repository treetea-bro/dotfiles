return {
	{
		"neovim/nvim-lspconfig",
		opts = function(_, opts)
			local configs = require("lspconfig.configs")
			local util = require("lspconfig.util")

			local python_root_pattern = util.root_pattern("pyproject.toml")

			if not configs.pyrefly then
				configs.pyrefly = {
					default_config = {
						cmd = { "pyrefly", "lsp" },
						filetypes = { "python" },
						root_dir = python_root_pattern,
						settings = {},
						single_file_support = true,
					},
				}
			end

			opts.servers = opts.servers or {}
			opts.servers.pyrefly = {}

			opts.servers.pyright = {
				root_dir = python_root_pattern,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							autoImportCompletions = true,
						},
						-- 가상환경 사용하는 경우 venv 경로 설정
						venvPath = vim.fn.getcwd() .. "/.venv",
						pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
					},
				},
			}

			opts.servers.ruff_lsp = {
				root_dir = python_root_pattern,
				init_options = {
					settings = {
						args = {},
					},
				},
			}

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
