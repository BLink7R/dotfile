local ink = {}

local hl = vim.api.nvim_set_hl

local c = {
  fg = "NONE", -- 0F
  bg = "NONE", -- 00
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
}

ink.set_up = function()
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
      vim.cmd("syntax reset")
  end
  vim.o.termguicolors = false
  vim.g.colors_name = "ink"

  hl(0, "Visual",                  { ctermbg = c.bg_mid })
  hl(0, "NonText",                 { ctermfg = c.red, ctermbg = c.bg })
  hl(0, "LineNr",                  { ctermfg = c.bg_mid, ctermbg = c.bg, cterm = { bold = true } })
  hl(0, "StatusLine",              { ctermfg = c.fg, ctermbg = c.bg })

  hl(0, "SnacksIndentScope",       { ctermfg = c.red, ctermbg = c.bg })

  hl(0, "NoiceCmdlineIcon",        { ctermfg = c.fg, ctermbg = c.bg })
  hl(0, "NoiceScrollbarThumb",     { ctermfg = c.fg, ctermbg = c.bg })
  hl(0, "NoiceScrollbar",          { ctermfg = c.fg, ctermbg = c.bg_mid })
  hl(0, "NoiceCmdlinePopupBorder", { ctermfg = c.red, ctermbg = c.bg })    
end     

ink.colors = c

ink.set_up()

return ink