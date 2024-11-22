-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

-- Delete a word backwards
keymap.set("n", "dw", "vb_d")
-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

vim.keymap.set("n", "<C-u>", require("dial.map").inc_normal(), { noremap = true })
vim.keymap.set("n", "<C-d>", require("dial.map").dec_normal(), { noremap = true })
-- -- Tab
-- local opts = { noremap = true, silent = true }
-- keymap.set("n", "te", ":tabedit<Return>", opts)
-- keymap.set("n", "<tab>", ":tabnext<Return>", opts)
-- keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)
