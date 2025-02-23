-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.api.nvim_set_keymap('n', 'gl', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gs', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'gl', '$', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'gs', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ')', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '(', ':bprevious<CR>', { noremap = true, silent = true })