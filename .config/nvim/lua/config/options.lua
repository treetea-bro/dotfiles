-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.g.python3_host_prog = '.venv/bin/python3'
vim.opt.relativenumber = false

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = false

-- vim.scriptencoding = "utf-8"
-- vim.opt.encoding = "utf-8"
-- vim.opt.fileencoding = "utf-8"

-- change neo-tree root directory to when it first opend directory
vim.opt.autochdir = false
vim.g.root_spec = { "cwd" }
