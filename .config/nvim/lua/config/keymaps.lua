-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Delete a word backwards
-- keymap.set("n", "dw", "vb_d")

-- Select all
-- keymap.set("n", "<C-a>", "gg<S-v>G")

-- Resize window
keymap.set("n", "<C-Left>", ":vertical resize -10<CR>", { noremap = true, silent = true })
keymap.set("n", "<C-Right>", ":vertical resize +10<CR>", { noremap = true, silent = true })

-- -- Tab
-- local opts = { noremap = true, silent = true }
-- keymap.set("n", "te", ":tabedit<Return>", opts)
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)
