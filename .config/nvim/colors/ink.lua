local ink = {}

local hl = vim.api.nvim_set_hl

local c = {
  fg = "NONE",
  bg = "NONE",
  black = 0,
  fg_mid = 7,
  bg_mid = 8,
  red_bg = 1,
  green_bg = 2,
  yellow_bg = 3,
  blue_bg = 4,
  purple_bg = 5,
  cyan_bg = 6,
  red = 9,
  green = 10,
  yellow = 11,
  blue = 12,
  purple = 13,
  cyan = 14,
  white = 15,
}

ink.set_up = function()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = false
  vim.o.background = "dark"
  vim.g.colors_name = "ink"
  
  hl(0, "Pmenu",                   { ctermfg = c.fg, ctermbg = c.bg, cterm = {} })
  hl(0, "PmenuSel",                { ctermfg = c.fg, ctermbg = c.bg_mid, cterm = { underline = true, bold = true } })
  hl(0, "PmenuThumb",              { ctermbg = c.fg_mid })
  hl(0, "PmenuSbar",               { ctermbg = c.bg_mid })

  hl(0, "Visual",                  { ctermbg = c.bg_mid })
  hl(0, "NonText",                 { ctermfg = c.fg_mid, ctermbg = c.bg })
  hl(0, "WhiteSpace",              { ctermfg = c.bg_mid, ctermbg = c.bg })
  hl(0, "LineNr",                  { ctermfg = c.fg_mid, ctermbg = c.bg })
  hl(0, "CursorLineNr",            { ctermfg = c.fg, ctermbg = c.bg, cterm = { bold = true } })
  hl(0, "StatusLine",              { ctermfg = c.fg })
  hl(0, "StatusLineNc",            { ctermfg = c.fg })

  hl(0, "DiagnosticError",         { ctermfg = c.red, ctermbg = c.bg})
  hl(0, "DiagnosticWarn",          { ctermfg = c.yellow, ctermbg = c.bg})
  hl(0, "DiagnosticInfo",          { ctermfg = c.cyan, ctermbg = c.bg})
  hl(0, "DiagnosticHint",          { ctermfg = c.blue, ctermbg = c.bg})
  hl(0, "DiagnosticOk",            { ctermfg = c.green, ctermbg = c.bg})

  hl(0, "Comment",                 { ctermfg = c.fg_mid, ctermbg = c.bg}) 
  hl(0, "Constant",                { ctermfg = c.purple, ctermbg = c.bg}) 
  hl(0, "Function",                { ctermfg = c.green, ctermbg = c.bg}) 
  hl(0, "Identifier",              { ctermfg = c.fg, ctermbg = c.bg}) 
  hl(0, "Keyword",                 { ctermfg = c.red, ctermbg = c.bg}) 
  hl(0, "Number",                  { ctermfg = c.purple, ctermbg = c.bg}) 
  hl(0, "Operator",                { ctermfg = c.red, ctermbg = c.bg}) 
  hl(0, "PreProc",                 { ctermfg = c.cyan, ctermbg = c.bg}) 
  hl(0, "Special",                 { ctermfg = c.blue, ctermbg = c.bg, cterm = { bold = true } }) 
  hl(0, "String",                  { ctermfg = c.purple, ctermbg = c.bg, cterm = { italic = true } }) 
  hl(0, "Type",                    { ctermfg = c.blue, ctermbg = c.bg, cterm = { bold = true, underline = true } }) 

  hl(0, "SnacksIndentScope",       { ctermfg = c.fg_mid, ctermbg = c.bg })

  hl(0, "NoiceCmdlineIcon",        { ctermfg = c.red, ctermbg = c.bg })
  hl(0, "NoiceScrollbarThumb",     { ctermfg = c.fg, ctermbg = c.bg })
  hl(0, "NoiceScrollbar",          { ctermfg = c.fg, ctermbg = c.bg_mid })
  hl(0, "NoiceCmdlinePopupBorder", { ctermfg = c.red, ctermbg = c.bg }) 

  require("lualine").setup({
    options = {
      theme = ink.lualine,
    },
  })
end

ink.lualine = {
  visual = {
    a = { fg = c.white, bg = c.blue, gui = 'bold' },
    b = { fg = c.white, bg = c.cyan },
    c = { fg = c.fg, bg = c.bg },
  },
  inactive = {
    a = { gui = 'reverse' },
    b = { fg = c.fg_mid, bg = c.bg_mid },
    c = { fg = c.fg, bg = c.bg },
  },
  insert = {
    a = { fg = c.white, bg = c.red, gui = 'bold' },
    b = { fg = c.white, bg = c.purple },
    c = { fg = c.fg, bg = c.bg },
  },
  replace = {
    a = { fg = c.white, bg = c.red, gui = 'bold' },
    b = { fg = c.white, bg = c.purple },
    c = { fg = c.fg, bg = c.bg },
  },
  normal = {
    a = { fg = c.white, bg = c.blue, gui = 'bold' },
    b = { fg = c.white, bg = c.cyan },
    c = { fg = c.fg, bg = c.bg },
  },
}

ink.colors = c

ink.set_up()

return ink
