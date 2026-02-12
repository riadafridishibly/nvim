-- Milk Tea Colorscheme for Neovim
-- Based on warm milk tea colors

vim.opt.background = 'light'

local colors = {
	bg = '#e6d5c3',
	fg = '#3d5a68',
	black = '#073642',
	red = '#e84642',
	green = '#969b00',
	yellow = '#a57200', -- Darker gold for better contrast
	blue = '#1e7ab8',  -- Darker navy blue (was #2e9ce6)
	magenta = '#c23a7d', -- Darker magenta (was #df478d)
	cyan = '#1d8a82',  -- Darker teal (was #32b0a8)
	white = '#eee8d5',
	dark_black = '#002b36',
	bright_red = '#d64e10',
	dark_green = '#586e75',
	dark_yellow = '#657b83',
	dark_blue = '#839496',
	dark_magenta = '#6c71c4',
	dark_cyan = '#93a1a1',
	light_bg = '#f0e6d6',
	dark_bg = '#d8c7b5',
	comment = '#839496',
	cursorline = '#f0e6d6',
	selection = '#df478d',
	string = '#7a8f00',        -- Darker, more contrasty olive green
	string_emphasis = '#586e00', -- Even darker for emphasis
}

local groups = {
	-- UI
	Normal = { fg = colors.fg, bg = colors.bg },
	NormalFloat = { fg = colors.fg, bg = colors.light_bg },
	Cursor = { bg = colors.fg, fg = colors.bg },
	CursorLine = { bg = colors.cursorline },
	CursorColumn = { bg = colors.cursorline },
	ColorColumn = { bg = colors.light_bg },
	LineNr = { fg = colors.dark_yellow, bg = colors.bg },
	CursorLineNr = { fg = colors.yellow, bg = colors.bg, bold = true },
	VertSplit = { fg = colors.dark_bg, bg = colors.bg },
	StatusLine = { fg = colors.fg, bg = colors.light_bg },
	StatusLineNC = { fg = colors.dark_yellow, bg = colors.light_bg },
	Pmenu = { fg = colors.fg, bg = colors.light_bg },
	PmenuSel = { fg = colors.bg, bg = colors.blue },
	PmenuSbar = { bg = colors.dark_bg },
	PmenuThumb = { bg = colors.dark_yellow },
	WildMenu = { fg = colors.bg, bg = colors.blue },
	Visual = { bg = colors.dark_bg },
	VisualNOS = { bg = colors.dark_bg },
	Search = { bg = colors.yellow, fg = colors.black },
	IncSearch = { bg = colors.red, fg = colors.white },
	MatchParen = { bg = colors.dark_bg, bold = true },
	Folded = { fg = colors.dark_yellow, bg = colors.light_bg },
	FoldColumn = { fg = colors.dark_yellow, bg = colors.bg },
	SignColumn = { fg = colors.dark_yellow, bg = colors.bg },
	ErrorMsg = { fg = colors.red, bold = true },
	WarningMsg = { fg = colors.yellow, bold = true },
	ModeMsg = { fg = colors.green },
	MoreMsg = { fg = colors.green },
	Question = { fg = colors.blue },
	Title = { fg = colors.magenta, bold = true },
	SpecialKey = { fg = colors.dark_cyan },
	NonText = { fg = colors.dark_bg },
	Directory = { fg = colors.blue },
	Conceal = { fg = colors.dark_yellow },

	-- Syntax
	Comment = { fg = colors.comment, italic = true },
	Constant = { fg = colors.cyan },
	String = { fg = colors.string },
	Character = { fg = colors.string },
	Number = { fg = colors.magenta },
	Boolean = { fg = colors.magenta },
	Float = { fg = colors.magenta },
	Identifier = { fg = colors.blue },
	Function = { fg = colors.dark_black, bold = true }, -- Different from identifiers, darker magenta
	Statement = { fg = colors.red },
	Conditional = { fg = colors.red },
	Repeat = { fg = colors.red },
	Label = { fg = colors.yellow },
	Operator = { fg = colors.fg },
	Keyword = { fg = colors.red },
	Exception = { fg = colors.red },
	PreProc = { fg = colors.magenta },
	Include = { fg = colors.red },
	Define = { fg = colors.magenta },
	Macro = { fg = colors.magenta },
	PreCondit = { fg = colors.magenta },
	Type = { fg = colors.yellow },
	StorageClass = { fg = colors.yellow },
	Structure = { fg = colors.yellow },
	Typedef = { fg = colors.yellow },
	Special = { fg = colors.red },
	SpecialChar = { fg = colors.red },
	Tag = { fg = colors.blue },
	Delimiter = { fg = colors.fg },
	SpecialComment = { fg = colors.comment, bold = true },
	Debug = { fg = colors.red },
	Underlined = { underline = true },
	Bold = { bold = true },
	Italic = { italic = true },
	Ignore = { fg = colors.dark_bg },
	Error = { fg = colors.red, bold = true },
	Todo = { fg = colors.yellow, bg = colors.light_bg, bold = true },

	-- LSP
	LspReferenceText = { bg = colors.cursorline },
	LspReferenceRead = { bg = colors.cursorline },
	LspReferenceWrite = { bg = colors.cursorline },
	DiagnosticError = { fg = colors.red },
	DiagnosticWarn = { fg = colors.yellow },
	DiagnosticInfo = { fg = colors.blue },
	DiagnosticHint = { fg = colors.cyan },
	DiagnosticUnderlineError = { sp = colors.red, underline = true },
	DiagnosticUnderlineWarn = { sp = colors.yellow, underline = true },
	DiagnosticUnderlineInfo = { sp = colors.blue, underline = true },
	DiagnosticUnderlineHint = { sp = colors.cyan, underline = true },

	-- Treesitter
	['@comment'] = { link = 'Comment' },
	['@variable'] = { fg = colors.fg },
	['@constant'] = { link = 'Constant' },
	['@constant.builtin'] = { link = 'Constant' },
	['@constant.macro'] = { link = 'Constant' },
	['@string'] = { fg = colors.string },
	['@string.regex'] = { fg = colors.cyan },
	['@string.escape'] = { fg = colors.red },
	['@character'] = { link = 'Character' },
	['@number'] = { link = 'Number' },
	['@float'] = { link = 'Float' },
	['@boolean'] = { link = 'Boolean' },
	['@function'] = { link = 'Function' },
	['@function.builtin'] = { link = 'Function' },
	['@function.macro'] = { link = 'Function' },
	['@parameter'] = { fg = colors.fg },
	['@method'] = { link = 'Function' },
	['@field'] = { fg = colors.yellow },
	['@property'] = { fg = colors.yellow },
	['@constructor'] = { link = 'Type' },
	['@conditional'] = { link = 'Conditional' },
	['@repeat'] = { link = 'Repeat' },
	['@label'] = { link = 'Label' },
	['@operator'] = { link = 'Operator' },
	['@keyword'] = { link = 'Keyword' },
	['@exception'] = { link = 'Exception' },
	['@type'] = { link = 'Type' },
	['@type.builtin'] = { link = 'Type' },
	['@type.definition'] = { link = 'Type' },
	['@storageclass'] = { link = 'StorageClass' },
	['@structure'] = { link = 'Structure' },
	['@namespace'] = { fg = colors.yellow },
	['@include'] = { link = 'Include' },
	['@preproc'] = { link = 'PreProc' },
	['@debug'] = { link = 'Debug' },
	['@tag'] = { link = 'Tag' },
	['@tag.delimiter'] = { fg = colors.dark_yellow },
	['@tag.attribute'] = { fg = colors.green },

	-- Git
	DiffAdd = { bg = '#e8f5e9', fg = colors.green },
	DiffChange = { bg = '#fff3e0', fg = colors.yellow },
	DiffDelete = { bg = '#ffebee', fg = colors.red },
	DiffText = { bg = '#ffe0b2', fg = colors.yellow },
	diffAdded = { fg = colors.green },
	diffRemoved = { fg = colors.red },
	diffChanged = { fg = colors.yellow },
	diffOldFile = { fg = colors.red },
	diffNewFile = { fg = colors.green },
	diffFile = { fg = colors.blue },
	diffLine = { fg = colors.dark_yellow },
	diffIndexLine = { fg = colors.magenta },

	-- NeoTree
	NeoTreeNormal = { fg = colors.fg, bg = colors.bg },
	NeoTreeNormalNC = { fg = colors.fg, bg = colors.bg },
	NeoTreeRootName = { fg = colors.magenta, bold = true },
	NeoTreeDirectoryName = { fg = colors.dark_yellow },
	NeoTreeDirectoryIcon = { fg = colors.blue },
	NeoTreeFileName = { fg = colors.fg },
	NeoTreeFileNameOpened = { fg = colors.blue, bold = true },
	NeoTreeFileIcon = { fg = colors.fg },
	NeoTreeCursorLine = { bg = colors.dark_bg, bold = true },
	NeoTreeFloatBorder = { fg = colors.dark_bg, bg = colors.bg },
	NeoTreeFloatNormal = { fg = colors.fg, bg = colors.bg },
	NeoTreeFloatTitle = { fg = colors.magenta, bg = colors.bg, bold = true },
	NeoTreeGitAdded = { fg = colors.green },
	NeoTreeGitDeleted = { fg = colors.red },
	NeoTreeGitModified = { fg = colors.yellow },
	NeoTreeGitUnstaged = { fg = colors.red },
	NeoTreeGitStaged = { fg = colors.green },
	NeoTreeGitConflict = { fg = colors.magenta, bold = true },
	NeoTreeGitUntracked = { fg = colors.cyan },
	NeoTreeIndentMarker = { fg = colors.dark_bg },
	NeoTreeExpander = { fg = colors.dark_yellow },
	NeoTreeSymbolicLinkTarget = { fg = colors.magenta },
	NeoTreeTitleBar = { fg = colors.fg, bg = colors.dark_bg },
	NeoTreeStatusLine = { fg = colors.fg, bg = colors.light_bg },
}

for group, settings in pairs(groups) do
	vim.api.nvim_set_hl(0, group, settings)
end

vim.g.terminal_color_0 = colors.black
vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_4 = colors.blue
vim.g.terminal_color_5 = colors.magenta
vim.g.terminal_color_6 = colors.cyan
vim.g.terminal_color_7 = colors.white
vim.g.terminal_color_8 = colors.dark_black
vim.g.terminal_color_9 = colors.bright_red
vim.g.terminal_color_10 = colors.dark_green
vim.g.terminal_color_11 = colors.dark_yellow
vim.g.terminal_color_12 = colors.dark_blue
vim.g.terminal_color_13 = colors.dark_magenta
vim.g.terminal_color_14 = colors.dark_cyan
vim.g.terminal_color_15 = colors.bg
