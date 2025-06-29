return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	lazy = false,
	version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
	opts = {
		providers = {
			openai = {
				endpoint = "https://api.openai.com/v1",
				model = "gpt-4o-mini", -- your desired model (or use gpt-4o, etc.)
				timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
				extra_request_body = {
					temperature = 0,
					max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
					reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
				},
			},
			ollama = {
				endpoint = "http://127.0.0.1:11434",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					options = {
						temperature = 0.75,
						num_ctx = 20480,
						keep_alive = "5m",
					},
				},
			},
			groq = {
				__inherited_from = "openai",
				api_key_name = "GROQ_API_KEY",
				endpoint = "https://api.groq.com/openai/v1/",
				model = "llama-3.3-70b-versatile",
				disable_tools = true,
				extra_request_body = {
					temperature = 1,
					max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
				},
			},
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	build = "make",
	-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
	dependencies = {
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"echasnovski/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
