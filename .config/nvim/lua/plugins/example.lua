-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
if true then return {
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
      opts.picker ={
        sources = {
          files = { hidden = true },
        },
      }
    end
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
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
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
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
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
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {
          'filename',
          {
            'diagnostics',
            symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '},
            colored = false,
            update_in_insert = false,
            always_visible = false,
          },
        },
        lualine_x = {
          {
            'encoding',
            show_bomd = true,
          },
          {
            'fileformat',
            symbols = {
              unix = '', -- e712
              dos = '',  -- e70f
              mac = '',  -- e711
            }
          },
          'filetype',
        },
        lualine_y = {
          {
            'progress',
            separator = '',
          },
          {
            'location',
            separator = '',
          },
        },
        lualine_z = {
          {
            'datetime',
            icon = '',
            style = '%H:%M'
          },
        },
      },
    }
  }
} end