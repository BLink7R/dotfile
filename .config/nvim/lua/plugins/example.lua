return {
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<C-K>", "<cmd>lua vim.lsp.buf.hover()<cr>" }
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>",  desc = "Open Diffview",  mode = { 'n', 'x' } },
      { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Close Diffview", mode = { 'n', 'x' } },
    },
    config = function()
      -- 可选：自定义配置
      require("diffview").setup({})
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy"
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    -- build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
    keys = {
      { "<leader>wc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat Window", mode = { 'n', 'x' } },
    },
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   event = "VeryLazy",
  --   opts = function()
  --     local opts = {
  --       sections = {
  --         lualine_a = { 'mode' },
  --         lualine_b = { 'branch', 'diff' },
  --         lualine_c = {
  --           'filename',
  --           {
  --             'diagnostics',
  --             symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  --             colored = false,
  --             update_in_insert = false,
  --             always_visible = false,
  --           },
  --           { LazyVim.lualine.pretty_path() },
  --         },
  --         lualine_x = {{
  --             function() return require("noice").api.status.command.get() end,
  --             cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
  --             color = function() return { fg = Snacks.util.color("Statement") } end,
  --           },
  --           { 'encoding', show_bomd = true, },
  --           {
  --             'fileformat',
  --             symbols = { unix = '', dos = '', mac = '', }
  --           },
  --           'filetype',
  --         },
  --         lualine_y = {
  --           { 'progress', separator = '', },
  --           { 'location', separator = '', },
  --         },
  --         lualine_z = {
  --           { 'datetime', icon = '', style = '%H:%M' },
  --         },
  --       },
  --     }
  --     return opts
  --   end,
  -- }
}
