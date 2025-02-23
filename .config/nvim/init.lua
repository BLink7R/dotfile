-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
Snacks.scroll.disable()
require("nvim-treesitter.install").prefer_git = true
vim.cmd("colorscheme ink")