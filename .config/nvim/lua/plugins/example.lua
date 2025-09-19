local show_ignore_file = false
local show_hidden_file = false

return {
  {
    "amitds1997/remote-nvim.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- For standard functions
      "MunifTanjim/nui.nvim",          -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    config = true,
  },
  {
    "nvim-mini/mini.ai",
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    opts = {
      plugins = {
        presets = {
          operators = false,
          motions = false,
          g = false,
        }
      }
    }
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = function(_, opts)
      Snacks.toggle({
        name = "tab indent",
        get = function()
          return vim.bo.shiftwidth == 4
        end,
        set = function(state)
          if state then
            vim.bo.shiftwidth = 4
            vim.bo.tabstop = 4
            vim.bo.expandtab = false
          else
            vim.bo.shiftwidth = 2
            vim.bo.tabstop = 2
            vim.bo.expandtab = true
          end
        end,
      }):map("<leader>u<Tab>")
      Snacks.toggle({
        name = "ignored files",
        get = function()
          return show_ignore_file
        end,
        set = function(state)
          show_ignore_file = state
        end,
      }):map("<leader>fi")
      Snacks.toggle({
        name = "hidden files",
        get = function()
          return show_hidden_file
        end,
        set = function(state)
          show_hidden_file = state
        end,
      }):map("<leader>fh")
    end,

    keys = {
      {
        "<leader>ff",
        function()
          Snacks.picker.files({ ignored = show_ignore_file, hidden = show_hidden_file })
        end,
        desc = "Find Files (cwd)"
      },
      {
        "<leader>fF",
        function()
          Snacks.picker.files({ cwd = LazyVim.root(), ignored = show_ignore_file, hidden = show_hidden_file })
        end,
        desc = "Find Files (Root dir)"
      },
      {
        "<leader>e",
        function()
          Snacks.explorer({ ignored = show_ignore_file, hidden = show_hidden_file })
        end,
        desc = "Find Files (cwd)"
      },
      {
        "<leader>E",
        function()
          Snacks.explorer({ cwd = LazyVim.root(), ignored = show_ignore_file, hidden = show_hidden_file })
        end,
        desc = "Find Files (Root dir)"
      },
    }
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gz", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
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
      { "<leader>gv", "<cmd>DiffviewOpen<cr>",  desc = "Open Diffview" },
      { "<leader>gV", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
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
      { "<leader>wc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat Window" },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
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
  }
}
