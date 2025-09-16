-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = false
vim.g.autoformat = false

-- make vim cursor similar to gui editors
vim.o.selection = "exclusive"
vim.o.virtualedit = vim.o.virtualedit .. ",onemore"
vim.o.guicursor = "n-v-c:ver25,i-ci-ve:ver25,r-cr:hor20,o:hor50"

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    callback = function()
        vim.cmd("normal! l")
    end,
})
