-- gruber-darker.nvim
-- Port of gruber-darker Emacs theme to Neovim

local colors = {
	-- softened whites / foreground
	fg        = "#d4d4df", -- was #e4e4ef
	fg1       = "#e2e2ea", -- was #f4f4ff
	fg2       = "#e6e6e6", -- was #f5f5f5
	white     = "#e8e8e8", -- was #ffffff
	black     = "#000000",

	bg_1      = "#101010",
	bg        = "#181818",
	bg1       = "#282828",
	bg2       = "#453d41",
	bg3       = "#484848",
	bg4       = "#52494e",

	red_1     = "#c73c3f",
	red       = "#f43841",
	red1      = "#ff4f58",
	green     = "#73c936",
	yellow    = "#ffdd33",
	brown     = "#cc8c3c",
	quartz    = "#95a99f",
	niagara_1 = "#5f627f",
	niagara   = "#96a6c8",
	wisteria  = "#9e95c7",
}

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end

vim.g.colors_name = "gruber-darker"

local set = vim.api.nvim_set_hl

-- UI

set(0, "StatusLine", { fg = colors.fg1, bg = colors.bg1 })
set(0, "Normal", { fg = colors.fg, bg = colors.bg })
set(0, "CursorLine", { bg = colors.bg1 })
set(0, "Visual", { bg = colors.bg3 })
set(0, "LineNr", { fg = colors.quartz, bg = colors.bg })
set(0, "CursorLineNr", { fg = colors.yellow, bold = true })
set(0, "StatusLine", { fg = colors.fg1, bg = colors.bg1 })
set(0, "StatusLineNC", { fg = colors.quartz, bg = colors.bg1 })
set(0, "VertSplit", { fg = colors.bg2 })
set(0, "Pmenu", { fg = colors.fg, bg = colors.bg1 })
set(0, "PmenuSel", { fg = colors.fg, bg = colors.bg_1 })
set(0, "Search", { fg = colors.black, bg = colors.fg2 })
set(0, "IncSearch", { fg = colors.black, bg = colors.yellow })
set(0, "MatchParen", { bg = colors.bg4 })

-- Syntax
set(0, "Comment", { fg = colors.brown, italic = true })
set(0, "Constant", { fg = colors.quartz })
set(0, "String", { fg = colors.green })
set(0, "Character", { fg = colors.green })
set(0, "Number", { fg = colors.quartz })
set(0, "Boolean", { fg = colors.quartz })
set(0, "Float", { fg = colors.quartz })

set(0, "Identifier", { fg = colors.fg1 })
set(0, "Function", { fg = colors.niagara })

set(0, "Statement", { fg = colors.yellow, bold = true })
set(0, "Conditional", { fg = colors.yellow })
set(0, "Repeat", { fg = colors.yellow })
set(0, "Keyword", { fg = colors.yellow, bold = true })
set(0, "Operator", { fg = colors.yellow })

set(0, "Type", { fg = colors.quartz })
set(0, "PreProc", { fg = colors.quartz })

set(0, "Special", { fg = colors.wisteria })
set(0, "Todo", { fg = colors.black, bg = colors.yellow, bold = true })

-- Diff / Git
set(0, "DiffAdd", { fg = colors.green })
set(0, "DiffDelete", { fg = colors.red1 })
set(0, "DiffChange", { fg = colors.yellow })
set(0, "DiffText", { fg = colors.yellow, bold = true })

-- Diagnostics (LSP)
set(0, "DiagnosticError", { fg = colors.red })
set(0, "DiagnosticWarn", { fg = colors.yellow })
set(0, "DiagnosticInfo", { fg = colors.green })
set(0, "DiagnosticHint", { fg = colors.niagara })

-- Spell
set(0, "SpellBad", { undercurl = true, sp = colors.red })
set(0, "SpellCap", { undercurl = true, sp = colors.yellow })
set(0, "SpellLocal", { undercurl = true, sp = colors.green })

-- Links
set(0, "Title", { fg = colors.niagara, bold = true })
set(0, "Directory", { fg = colors.niagara, bold = true })
set(0, "ErrorMsg", { fg = colors.red })
set(0, "WarningMsg", { fg = colors.yellow })


-- Tree-sitter highlights
local ts = {
  ["@comment"]        = { fg = colors.brown, italic = true },

  ["@variable"]       = { fg = colors.fg1 },
  ["@variable.builtin"] = { fg = colors.red1 },

  ["@constant"]       = { fg = colors.quartz },
  ["@constant.builtin"] = { fg = colors.yellow },

  ["@string"]         = { fg = colors.green },
  ["@string.escape"]  = { fg = colors.wisteria },

  ["@number"]         = { fg = colors.quartz },
  ["@boolean"]        = { fg = colors.quartz },

  ["@function"]       = { fg = colors.niagara },
  ["@function.builtin"] = { fg = colors.yellow },

  ["@method"]         = { fg = colors.niagara },

  ["@keyword"]        = { fg = colors.yellow, bold = true },
  ["@keyword.function"] = { fg = colors.yellow, bold = true },
  ["@keyword.return"] = { fg = colors.yellow },

  ["@operator"]       = { fg = colors.yellow },

  ["@type"]           = { fg = colors.quartz },
  ["@type.builtin"]   = { fg = colors.wisteria },

  ["@property"]       = { fg = colors.fg },

  ["@field"]          = { fg = colors.fg },

  ["@punctuation"]    = { fg = colors.fg },

  ["@constructor"]    = { fg = colors.niagara },

  ["@tag"]            = { fg = colors.red },
  ["@tag.attribute"]  = { fg = colors.quartz },
  ["@tag.delimiter"]  = { fg = colors.fg },
}

for group, spec in pairs(ts) do
  set(0, group, spec)
end


vim.api.nvim_set_hl(0, "TSKeyword", { link = "@keyword" })
vim.api.nvim_set_hl(0, "TSFunction", { link = "@function" })
vim.api.nvim_set_hl(0, "TSString", { link = "@string" })
vim.api.nvim_set_hl(0, "TSComment", { link = "@comment" })
