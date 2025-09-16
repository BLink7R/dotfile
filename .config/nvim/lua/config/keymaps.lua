-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set('n', 'gl', '$', { noremap = true, silent = true })
vim.keymap.set('n', 'gs', '^', { noremap = true, silent = true })
vim.keymap.set('n', 'U', ':redo<cr>', { noremap = true, silent = true })
vim.keymap.set('n', 'J', '<PageDown>', { noremap = true, silent = true })
vim.keymap.set('n', 'K', '<PageUp>', { noremap = true, silent = true })
vim.keymap.set('v', 'gl', '$', { noremap = true, silent = true })
vim.keymap.set('v', 'gs', '^', { noremap = true, silent = true })
vim.keymap.set('v', 'U', ':redo<cr>', { noremap = true, silent = true })
vim.keymap.set('v', 'J', '<PageDown>', { noremap = true, silent = true })
vim.keymap.set('v', 'K', '<PageUp>', { noremap = true, silent = true })
vim.keymap.set('n', 'd', 'x', { noremap = true, silent = true })