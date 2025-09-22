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
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local opts = {
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff' },
          lualine_c = {
            'filename',
            {
              'diagnostics',
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
              colored = false,
              update_in_insert = false,
              always_visible = false,
            },
          },
          lualine_x = {
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              separator = '',
            },
            { 'encoding', show_bomd = true, },
            {
              'fileformat',
              symbols = { unix = '', dos = '', mac = '', }
            },
            'filetype',
          },
          lualine_y = {
            { 'progress', separator = '', },
            { 'location', separator = '', },
          },
          lualine_z = {
            { 'datetime', icon = '', style = '%H:%M' },
          },
        },
      }
      
      if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  }
}
