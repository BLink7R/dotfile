-- change keybingds to a helix style

-- register a keymap for both normal and visual mode
function helix_key(key, desc, func)
  return { key, func, desc = desc, mode = { 'n', 'x' } }
end

local show_i = false
local show_h = false

function snack_keys()
  local all_keys = {
    helix_key("<leader><space>", "Find Files (Root Dir)",
      function() Snacks.picker.files({ ignored = show_i, hidden = show_h }) end),
    helix_key("<leader>e", "Find Files (cwd)",
      function() Snacks.explorer({ ignored = show_i, hidden = show_h }) end),
    helix_key("<leader>E", "Find Files (Root dir)",
      function() Snacks.explorer({ cwd = LazyVim.root(), ignored = show_i, hidden = show_h }) end),
    helix_key("<leader>,", "Buffers", function() Snacks.picker.buffers() end),
    helix_key("<leader>/", "Grep (Root Dir)", LazyVim.pick("grep")),
    helix_key("<leader>:", "Command History", function() Snacks.picker.command_history() end),
    helix_key("<leader>n", "Notification History", function() Snacks.picker.notifications() end),
    -- find
    helix_key("<leader>fb", "Buffers", function() Snacks.picker.buffers() end),
    helix_key("<leader>fB", "Buffers (all)", function() Snacks.picker.buffers({ hidden = true, nofile = true }) end),
    helix_key("<leader>fc", "Find Config File", LazyVim.pick.config_files()),
    helix_key("<leader>ff", "Find Files (cwd)",
      function() Snacks.picker.files({ ignored = show_i, hidden = show_h }) end),
    helix_key("<leader>fF", "Find Files (Root dir)",
      function() Snacks.picker.files({ cwd = LazyVim.root(), ignored = show_i, hidden = show_h }) end),
    helix_key("<leader>fg", "Find Files (git-files)", function() Snacks.picker.git_files() end),
    helix_key("<leader>fr", "Recent", LazyVim.pick("oldfiles")),
    helix_key("<leader>fR", "Recent (cwd)", function() Snacks.picker.recent({ filter = { cwd = true } }) end),
    helix_key("<leader>fp", "Projects", function() Snacks.picker.projects() end),
    -- git
    helix_key("<leader>gb", "Git Blame Line", function() Snacks.picker.git_log_line() end),
    helix_key("<leader>gB", "Git Browse (open)", function() Snacks.gitbrowse() end),
    helix_key("<leader>gd", "Git Diff (hunks)", function() Snacks.picker.git_diff() end),
    helix_key("<leader>gs", "Git Status", function() Snacks.picker.git_status() end),
    helix_key("<leader>gS", "Git Stash", function() Snacks.picker.git_stash() end),
    helix_key("<leader>gY", "Git Browse (copy)",
      function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false }) end),
    -- Grep
    helix_key("<leader>sb", "Buffer Lines", function() Snacks.picker.lines() end),
    helix_key("<leader>sB", "Grep Open Buffers", function() Snacks.picker.grep_buffers() end),
    helix_key("<leader>sg", "Grep (Root Dir)", LazyVim.pick("live_grep")),
    helix_key("<leader>sG", "Grep (cwd)", LazyVim.pick("live_grep", { root = false })),
    helix_key("<leader>sp", "Search for Plugin Spec", function() Snacks.picker.lazy() end),
    helix_key("<leader>sw", "Visual selection or word (Root Dir)", LazyVim.pick("grep_word")),
    helix_key("<leader>sW", "Visual selection or word (cwd)", LazyVim.pick("grep_word", { root = false })),
    -- search
    helix_key('<leader>s"', "Registers", function() Snacks.picker.registers() end),
    helix_key('<leader>s/', "Search History", function() Snacks.picker.search_history() end),
    helix_key("<leader>sa", "Autocmds", function() Snacks.picker.autocmds() end),
    helix_key("<leader>sc", "Command History", function() Snacks.picker.command_history() end),
    helix_key("<leader>sC", "Commands", function() Snacks.picker.commands() end),
    helix_key("<leader>sd", "Diagnostics", function() Snacks.picker.diagnostics() end),
    helix_key("<leader>sD", "Buffer Diagnostics", function() Snacks.picker.diagnostics_buffer() end),
    helix_key("<leader>sh", "Help Pages", function() Snacks.picker.help() end),
    helix_key("<leader>sH", "Highlights", function() Snacks.picker.highlights() end),
    helix_key("<leader>si", "Icons", function() Snacks.picker.icons() end),
    helix_key("<leader>sj", "Jumps", function() Snacks.picker.jumps() end),
    helix_key("<leader>sk", "Keymaps", function() Snacks.picker.keymaps() end),
    helix_key("<leader>sl", "Location List", function() Snacks.picker.loclist() end),
    helix_key("<leader>sM", "Man Pages", function() Snacks.picker.man() end),
    helix_key("<leader>sm", "Marks", function() Snacks.picker.marks() end),
    helix_key("<leader>sR", "Resume", function() Snacks.picker.resume() end),
    helix_key("<leader>sq", "Quickfix List", function() Snacks.picker.qflist() end),
    helix_key("<leader>su", "Undotree", function() Snacks.picker.undo() end),
    -- ui
    helix_key("<leader>uC", "Colorschemes", function() Snacks.picker.colorschemes() end),
  }

  -- lazygit
  if vim.fn.executable("lazygit") == 1 then
    vim.list_extend(all_keys, {
      helix_key("<leader>gg", "Lazygit (Root Dir)", function() Snacks.lazygit({ cwd = LazyVim.root.git() }) end),
      helix_key("<leader>gG", "Lazygit (cwd)", function() Snacks.lazygit() end),
      helix_key("<leader>gf", "Git Current File History", function() Snacks.picker.git_log_file() end),
      helix_key("<leader>gl", "Git Log", function() Snacks.picker.git_log({ cwd = LazyVim.root.git() }) end),
      helix_key("<leader>gL", "Git Log (cwd)", function() Snacks.picker.git_log() end),
    })
  end

  return all_keys
end

return {
  {
    "folke/which-key.nvim",
    opts = {
      triggers = {
        { "<leader>", mode = "nixsotc" },
        { "g",        mode = "nixsotc" },
        { "gc",       mode = "nixsotc" },
        { "[",        mode = "nixsotc" },
        { "]",        mode = "nixsotc" },
        { "z",        mode = "nixsotc" },
        { "'",        mode = "nixsotc" },
        { "<C-w>",    mode = "nixsotc" },
      },
      spec = {
        { mode = { 'n', 'x' }, { "gs", group = false }, }
      },
      plugins = {
        presets = {
          operators = false,
          g = false,
        },
      }
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
        mode = { 'n', 'x' }
      },
      {
        "<c-w><space>",
        function()
          require("which-key").show({ keys = "<c-w>", loop = true })
        end,
        desc = "Window Hydra Mode (which-key)",
        mode = { 'n', 'x' }
      },
    }
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = function(_, opts)
      -- picker options
      Snacks.toggle({
        name = "show ignored",
        get = function() return show_i end,
        set = function(state) show_i = state end,
      }):map("<leader>fi", { mode = { 'n', 'x' } })
      Snacks.toggle({
        name = "show hidden",
        get = function() return show_h end,
        set = function(state) show_h = state end,
      }):map("<leader>fh", { mode = { 'n', 'x' } })
      -- toggle options
      Snacks.toggle({
        name = "tab indent",
        get = function() return vim.bo.shiftwidth == 4 end,
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
      }):map("<leader>u<Tab>", { mode = { 'n', 'x' } })
      LazyVim.format.snacks_toggle():map("<leader>uf", { mode = { 'n', 'x' } })
      LazyVim.format.snacks_toggle(true):map("<leader>uF", { mode = { 'n', 'x' } })
      Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us", { mode = { 'n', 'x' } })
      Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw", { mode = { 'n', 'x' } })
      Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL", { mode = { 'n', 'x' } })
      Snacks.toggle.diagnostics():map("<leader>ud", { mode = { 'n', 'x' } })
      Snacks.toggle.line_number():map("<leader>ul", { mode = { 'n', 'x' } })
      Snacks.toggle.option("conceallevel",
        { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
      ):map("<leader>uc", { mode = { 'n', 'x' } })
      Snacks.toggle.option("showtabline",
        { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" }
      ):map("<leader>uA", { mode = { 'n', 'x' } })
      Snacks.toggle.treesitter():map("<leader>uT", { mode = { 'n', 'x' } })
      Snacks.toggle.option("background",
        { off = "light", on = "dark", name = "Dark Background" }
      ):map("<leader>ub", { mode = { 'n', 'x' } })
      Snacks.toggle.dim():map("<leader>uD", { mode = { 'n', 'x' } })
      Snacks.toggle.animate():map("<leader>ua", { mode = { 'n', 'x' } })
      Snacks.toggle.indent():map("<leader>ug", { mode = { 'n', 'x' } })
      Snacks.toggle.scroll():map("<leader>uS", { mode = { 'n', 'x' } })
      Snacks.toggle.profiler():map("<leader>dpp", { mode = { 'n', 'x' } })
      Snacks.toggle.profiler_highlights():map("<leader>dph", { mode = { 'n', 'x' } })

      if vim.lsp.inlay_hint then
        Snacks.toggle.inlay_hints():map("<leader>uh", { mode = { 'n', 'x' } })
      end
    end,
    keys = snack_keys(),
  },
  -- disable some unwanted keybindings
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        keymaps = false,
      },
    }
  },
  {
    "nvim-mini/mini.ai",
    enabled = false,
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "folke/todo-comments.nvim",
    enabled = false,
  },
}
