-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
Snacks.scroll.disable()
require("nvim-treesitter.install").prefer_git = true
vim.cmd("colorscheme ink")

local system_type = vim.loop.os_uname().sysname
if system_type:match("Windows") then
  vim.o.shell = "powershell"
end