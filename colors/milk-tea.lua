-- Milk Tea Colorscheme for Neovim
-- Based on warm milk tea colors

vim.opt.background = 'light'

local colors = {
	bg = '#e0cfbd',
	fg = '#334d59',

	red = '#b71a16',
	green = '#5f6200',
	yellow = '#7c5500',
	blue = '#186294',
	magenta = '#a23068',
	cyan = '#156862',

	string = '#526100',

	black = '#073642',
	dark_black = '#002b36',
	white = '#eee8d5',

	bright_red = '#d64e10',
	dark_green = '#586e75',
	dark_yellow = '#657b83',
	dark_blue = '#839496',
	dark_magenta = '#6c71c4',
	dark_cyan = '#93a1a1',

	light_bg = '#f0e6d6',
	dark_bg = '#d8c7b5',
	comment = '#8a7355',
	cursorline = '#f0e6d6',
	selection = '#a23068',

	diff_add = '#d4e8d4',
	diff_change = '#f5e8d4',
	diff_delete = '#f4d4d4',
	diff_text = '#f5d8b8',
}

local groups = {
	-- UI
	Normal = { fg = colors.fg, bg = colors.bg },
	NormalFloat = { fg = colors.fg, bg = colors.bg },
	NormalNC = { fg = colors.fg, bg = colors.bg },
	Cursor = { bg = colors.fg, fg = colors.bg },
	CursorLine = { bg = colors.cursorline },
	CursorColumn = { bg = colors.cursorline },
	ColorColumn = { bg = colors.light_bg },
	LineNr = { fg = colors.dark_yellow, bg = colors.bg },
	CursorLineNr = { fg = colors.yellow, bg = colors.bg, bold = true },
	VertSplit = { fg = colors.dark_bg, bg = colors.bg },
	WinSeparator = { fg = colors.dark_bg, bg = colors.bg },
	StatusLine = { fg = colors.fg, bg = colors.light_bg },
	StatusLineNC = { fg = colors.dark_yellow, bg = colors.light_bg },
	FloatBorder = { fg = colors.dark_yellow, bg = colors.bg },
	MsgArea = { fg = colors.fg, bg = colors.bg },
	WinBar = { fg = colors.fg, bg = colors.light_bg },
	WinBarNC = { fg = colors.dark_yellow, bg = colors.light_bg },
	Pmenu = { fg = colors.fg, bg = colors.light_bg },
	PmenuBorder = { fg = colors.dark_bg, bg = colors.light_bg },
	PmenuSel = { fg = colors.bg, bg = colors.blue },
	PmenuSbar = { bg = colors.dark_bg },
	PmenuThumb = { bg = colors.dark_yellow },
	WildMenu = { fg = colors.bg, bg = colors.blue },
	Visual = { fg = colors.white, bg = colors.selection },
	VisualNOS = { bg = colors.dark_bg },
	Search = { bg = colors.light_bg, fg = colors.fg, underline = true, },
	IncSearch = { bg = colors.magenta, fg = colors.white, bold = true, },
	CurSearch = { bg = colors.magenta, fg = colors.white, bold = true, },
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

	-- Spell
	SpellBad = { sp = colors.red, undercurl = true },
	SpellCap = { sp = colors.blue, undercurl = true },
	SpellLocal = { sp = colors.cyan, undercurl = true },
	SpellRare = { sp = colors.magenta, undercurl = true },

	-- QuickFix
	QuickFixLine = { bg = colors.light_bg, bold = true },
	qfLineNr = { fg = colors.dark_yellow },
	qfFileName = { fg = colors.blue },
	qfError = { fg = colors.red },

	-- Syntax (refined hierarchy)
	Comment = { fg = colors.comment, italic = true },
	SpecialComment = { fg = colors.comment, bold = true, italic = true },

	Constant = { fg = colors.magenta },
	String = { fg = colors.string },
	Character = { link = 'String' },
	Number = { link = 'Constant' },
	Boolean = { link = 'Constant' },
	Float = { link = 'Constant' },

	Identifier = { fg = colors.fg },
	Function = { fg = colors.blue, bold = true },

	Keyword = { fg = colors.red, bold = true },
	Statement = { link = 'Keyword' },
	Conditional = { link = 'Keyword' },
	Repeat = { link = 'Keyword' },
	Label = { fg = colors.yellow },
	Exception = { link = 'Keyword' },
	Include = { link = 'Keyword' },

	Type = { fg = colors.yellow, bold = true },
	StorageClass = { link = 'Type' },
	Structure = { link = 'Type' },
	Typedef = { link = 'Type' },

	PreProc = { fg = colors.magenta },
	Define = { link = 'PreProc' },
	Macro = { link = 'PreProc' },
	PreCondit = { link = 'PreProc' },

	Special = { fg = colors.cyan },
	SpecialChar = { link = 'Special' },
	Tag = { fg = colors.blue },

	Operator = { fg = colors.fg },
	Delimiter = { fg = colors.dark_yellow },

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
	['@variable.builtin'] = { fg = colors.magenta, italic = true },
	['@parameter'] = { fg = colors.dark_green, italic = true },

	['@constant'] = { link = 'Constant' },
	['@constant.builtin'] = { fg = colors.magenta, bold = true },
	['@constant.macro'] = { link = 'Constant' },

	['@string'] = { link = 'String' },
	['@string.regex'] = { fg = colors.cyan },
	['@string.escape'] = { fg = colors.cyan, bold = true },

	['@character'] = { link = 'Character' },
	['@number'] = { link = 'Number' },
	['@float'] = { link = 'Float' },
	['@boolean'] = { link = 'Boolean' },

	['@function'] = { link = 'Function' },
	['@function.builtin'] = { fg = colors.blue, bold = true },
	['@function.macro'] = { fg = colors.blue },
	['@method'] = { link = 'Function' },
	['@constructor'] = { fg = colors.yellow, bold = true },

	['@field'] = { fg = colors.cyan },
	['@property'] = { fg = colors.cyan },

	['@conditional'] = { link = 'Keyword' },
	['@repeat'] = { link = 'Keyword' },
	['@label'] = { link = 'Label' },
	['@operator'] = { link = 'Operator' },
	['@keyword'] = { link = 'Keyword' },
	['@keyword.function'] = { fg = colors.red, bold = true },
	['@keyword.operator'] = { fg = colors.red },
	['@keyword.return'] = { link = 'Keyword' },
	['@exception'] = { link = 'Exception' },

	['@type'] = { link = 'Type' },
	['@type.builtin'] = { fg = colors.yellow, bold = true },
	['@type.definition'] = { link = 'Type' },
	['@type.qualifier'] = { fg = colors.red },

	['@storageclass'] = { link = 'StorageClass' },
	['@structure'] = { link = 'Structure' },
	['@namespace'] = { fg = colors.yellow },
	['@module'] = { fg = colors.yellow },

	['@include'] = { link = 'Include' },
	['@preproc'] = { link = 'PreProc' },
	['@debug'] = { link = 'Debug' },

	['@tag'] = { link = 'Tag' },
	['@tag.delimiter'] = { fg = colors.dark_yellow },
	['@tag.attribute'] = { fg = colors.green },

	['@punctuation.delimiter'] = { fg = colors.dark_yellow },
	['@punctuation.bracket'] = { fg = colors.fg },
	['@punctuation.special'] = { fg = colors.magenta },

	['@text'] = { fg = colors.fg },
	['@text.title'] = { fg = colors.magenta, bold = true },
	['@text.literal'] = { fg = colors.string },
	['@text.emphasis'] = { italic = true },
	['@text.strong'] = { bold = true },
	['@text.underline'] = { underline = true },
	['@text.strike'] = { strikethrough = true },
	['@text.uri'] = { fg = colors.blue, underline = true },
	['@text.math'] = { fg = colors.cyan },
	['@text.reference'] = { fg = colors.blue },
	['@text.todo'] = { fg = colors.yellow, bold = true },
	['@text.note'] = { fg = colors.blue },
	['@text.warning'] = { fg = colors.yellow },
	['@text.danger'] = { fg = colors.red },

	['@diff.plus'] = { fg = colors.green },
	['@diff.minus'] = { fg = colors.red },
	['@diff.delta'] = { fg = colors.yellow },

	-- LSP Semantic Tokens
	['@lsp.type.class'] = { link = 'Type' },
	['@lsp.type.enum'] = { link = 'Type' },
	['@lsp.type.enumMember'] = { fg = colors.cyan },
	['@lsp.type.interface'] = { link = 'Type' },
	['@lsp.type.struct'] = { link = 'Type' },
	['@lsp.type.typeParameter'] = { link = 'Type' },
	['@lsp.type.parameter'] = { link = '@parameter' },
	['@lsp.type.variable'] = { link = '@variable' },
	['@lsp.type.property'] = { link = '@property' },
	['@lsp.type.function'] = { link = 'Function' },
	['@lsp.type.method'] = { link = 'Function' },
	['@lsp.type.macro'] = { link = '@function.macro' },
	['@lsp.type.keyword'] = { link = 'Keyword' },
	['@lsp.type.comment'] = { link = 'Comment' },
	['@lsp.type.string'] = { link = 'String' },
	['@lsp.type.number'] = { link = 'Number' },
	['@lsp.type.boolean'] = { link = 'Boolean' },
	['@lsp.type.regexp'] = { link = '@string.regex' },
	['@lsp.type.operator'] = { link = 'Operator' },
	['@lsp.type.namespace'] = { link = '@namespace' },
	['@lsp.type.module'] = { link = '@module' },
	['@lsp.mod.deprecated'] = { fg = colors.dark_yellow, strikethrough = true },
	['@lsp.mod.readonly'] = { link = '@constant' },

	-- Git
	DiffAdd = { bg = colors.diff_add, fg = colors.green },
	DiffChange = { bg = colors.diff_change, fg = colors.yellow },
	DiffDelete = { bg = colors.diff_delete, fg = colors.red },
	DiffText = { bg = colors.diff_text, fg = colors.yellow },

	diffAdded = { fg = colors.green },
	diffRemoved = { fg = colors.red },
	diffChanged = { fg = colors.yellow },
	diffOldFile = { fg = colors.red },
	diffNewFile = { fg = colors.green },
	diffFile = { fg = colors.blue },
	diffLine = { fg = colors.dark_yellow },
	diffIndexLine = { fg = colors.magenta },

	-- GitSigns
	GitSignsAdd = { fg = colors.green },
	GitSignsChange = { fg = colors.yellow },
	GitSignsDelete = { fg = colors.red },
	GitSignsAddNr = { fg = colors.green },
	GitSignsChangeNr = { fg = colors.yellow },
	GitSignsDeleteNr = { fg = colors.red },
	GitSignsAddLn = { fg = colors.green, bg = colors.diff_add },
	GitSignsChangeLn = { fg = colors.yellow, bg = colors.diff_change },
	GitSignsDeleteLn = { fg = colors.red, bg = colors.diff_delete },
	GitSignsCurrentLineBlame = { fg = colors.comment },

	-- GitSigns word diff
	GitSignsAddInline = { bg = colors.diff_add },
	GitSignsChangeInline = { bg = colors.diff_change },
	GitSignsDeleteInline = { bg = colors.diff_delete },

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

	-- Indent Blankline
	IblIndent = { fg = colors.dark_bg },
	IblScope = { fg = colors.dark_yellow },
	IblWhitespace = { fg = colors.dark_bg },
	IndentBlanklineIndent = { fg = colors.dark_bg },
	IndentBlanklineScope = { fg = colors.dark_yellow },
	IndentBlanklineSpaceChar = { fg = colors.dark_bg },
	IndentBlanklineSpaceCharBlankline = { fg = colors.dark_bg },

	-- Mini Statusline
	MiniStatuslineModeNormal = { fg = colors.bg, bg = colors.blue, bold = true },
	MiniStatuslineModeInsert = { fg = colors.bg, bg = colors.green, bold = true },
	MiniStatuslineModeVisual = { fg = colors.bg, bg = colors.magenta, bold = true },
	MiniStatuslineModeReplace = { fg = colors.bg, bg = colors.red, bold = true },
	MiniStatuslineModeCommand = { fg = colors.bg, bg = colors.yellow, bold = true },
	MiniStatuslineActive = { fg = colors.fg, bg = colors.light_bg },
	MiniStatuslineInactive = { fg = colors.dark_yellow, bg = colors.bg },
	MiniStatuslineFilename = { fg = colors.fg, bg = colors.dark_bg },
	MiniStatuslineDevinfo = { fg = colors.fg, bg = colors.dark_bg },
	MiniStatuslineFileinfo = { fg = colors.fg, bg = colors.dark_bg },

	-- FZF Lua
	FzfLuaNormal = { fg = colors.fg, bg = colors.bg },
	FzfLuaBorder = { fg = colors.dark_yellow, bg = colors.bg },
	FzfLuaTitle = { fg = colors.magenta, bg = colors.bg, bold = true },
	FzfLuaHeaderBind = { fg = colors.cyan },
	FzfLuaHeaderText = { fg = colors.comment },
	FzfLuaPathColNr = { fg = colors.yellow },
	FzfLuaPathLineNr = { fg = colors.dark_yellow },
	FzfLuaCursorLineNr = { fg = colors.yellow, bg = colors.dark_bg },
	FzfLuaFzfCursorLine = { fg = colors.bg, bg = colors.blue },
	FzfLuaPreviewTitle = { fg = colors.blue, bg = colors.bg, bold = true },

	-- Blink Cmp
	BlinkCmpMenu = { fg = colors.fg, bg = colors.light_bg },
	BlinkCmpMenuBorder = { fg = colors.dark_bg, bg = colors.light_bg },
	BlinkCmpMenuSelection = { fg = colors.bg, bg = colors.blue },
	BlinkCmpLabel = { fg = colors.fg },
	BlinkCmpLabelMatch = { fg = colors.blue, bold = true },
	BlinkCmpKind = { fg = colors.dark_yellow },
	BlinkCmpKindText = { fg = colors.string },
	BlinkCmpKindMethod = { fg = colors.blue },
	BlinkCmpKindFunction = { fg = colors.blue },
	BlinkCmpKindConstructor = { fg = colors.yellow },
	BlinkCmpKindField = { fg = colors.cyan },
	BlinkCmpKindVariable = { fg = colors.fg },
	BlinkCmpKindClass = { fg = colors.yellow },
	BlinkCmpKindInterface = { fg = colors.yellow },
	BlinkCmpKindModule = { fg = colors.magenta },
	BlinkCmpKindProperty = { fg = colors.cyan },
	BlinkCmpKindUnit = { fg = colors.dark_yellow },
	BlinkCmpKindValue = { fg = colors.magenta },
	BlinkCmpKindEnum = { fg = colors.yellow },
	BlinkCmpKindKeyword = { fg = colors.red },
	BlinkCmpKindSnippet = { fg = colors.green },
	BlinkCmpKindColor = { fg = colors.magenta },
	BlinkCmpKindFile = { fg = colors.fg },
	BlinkCmpKindReference = { fg = colors.blue },
	BlinkCmpKindFolder = { fg = colors.dark_yellow },
	BlinkCmpKindEnumMember = { fg = colors.cyan },
	BlinkCmpKindConstant = { fg = colors.magenta },
	BlinkCmpKindStruct = { fg = colors.yellow },
	BlinkCmpKindEvent = { fg = colors.magenta },
	BlinkCmpKindOperator = { fg = colors.fg },
	BlinkCmpKindTypeParameter = { fg = colors.yellow },
	BlinkCmpGhostText = { fg = colors.dark_bg },
	BlinkCmpDoc = { fg = colors.fg, bg = colors.bg },
	BlinkCmpDocBorder = { fg = colors.dark_yellow, bg = colors.bg },
	BlinkCmpDocCursorLine = { bg = colors.light_bg },
	BlinkCmpSignatureHelp = { fg = colors.fg, bg = colors.bg },
	BlinkCmpSignatureHelpBorder = { fg = colors.dark_yellow, bg = colors.bg },
	BlinkCmpSignatureHelpActiveParameter = { fg = colors.yellow, bold = true },

	-- LSP Signature
	LspSignatureActiveParameter = { fg = colors.yellow, bold = true },

	-- Todo Comments
	TodoBgTODO = { fg = colors.bg, bg = colors.blue, bold = true },
	TodoFgTODO = { fg = colors.blue },
	TodoBgHACK = { fg = colors.bg, bg = colors.yellow, bold = true },
	TodoFgHACK = { fg = colors.yellow },
	TodoBgWARN = { fg = colors.bg, bg = colors.yellow, bold = true },
	TodoFgWARN = { fg = colors.yellow },
	TodoBgPERF = { fg = colors.bg, bg = colors.magenta, bold = true },
	TodoFgPERF = { fg = colors.magenta },
	TodoBgNOTE = { fg = colors.bg, bg = colors.cyan, bold = true },
	TodoFgNOTE = { fg = colors.cyan },
	TodoBgTEST = { fg = colors.bg, bg = colors.green, bold = true },
	TodoFgTEST = { fg = colors.green },
	TodoBgFIX = { fg = colors.bg, bg = colors.red, bold = true },
	TodoFgFIX = { fg = colors.red },

	-- Oil
	OilDir = { fg = colors.blue },
	OilDirIcon = { fg = colors.blue },
	OilFile = { fg = colors.fg },
	OilLink = { fg = colors.cyan },
	OilLinkTarget = { fg = colors.dark_yellow },
	OilSocket = { fg = colors.magenta },
	OilCreate = { fg = colors.green },
	OilDelete = { fg = colors.red },
	OilMove = { fg = colors.yellow },
	OilCopy = { fg = colors.cyan },
	OilChange = { fg = colors.yellow },

	-- Markdown
	markdownH1 = { fg = colors.magenta, bold = true },
	markdownH2 = { fg = colors.blue, bold = true },
	markdownH3 = { fg = colors.cyan, bold = true },
	markdownH4 = { fg = colors.green, bold = true },
	markdownH5 = { fg = colors.yellow, bold = true },
	markdownH6 = { fg = colors.dark_yellow, bold = true },
	markdownH1Delimiter = { fg = colors.magenta },
	markdownH2Delimiter = { fg = colors.blue },
	markdownH3Delimiter = { fg = colors.cyan },
	markdownH4Delimiter = { fg = colors.green },
	markdownH5Delimiter = { fg = colors.yellow },
	markdownH6Delimiter = { fg = colors.dark_yellow },
	markdownCode = { fg = colors.string, bg = colors.dark_bg },
	markdownCodeBlock = { fg = colors.string },
	markdownCodeDelimiter = { fg = colors.cyan },
	markdownBlockquote = { fg = colors.comment },
	markdownListMarker = { fg = colors.yellow },
	markdownOrderedListMarker = { fg = colors.yellow },
	markdownRule = { fg = colors.dark_yellow },
	markdownHeadingRule = { fg = colors.dark_yellow },
	markdownUrlDelimiter = { fg = colors.dark_yellow },
	markdownLinkDelimiter = { fg = colors.dark_yellow },
	markdownLinkTextDelimiter = { fg = colors.dark_yellow },
	markdownUrl = { fg = colors.blue, underline = true },
	markdownLink = { fg = colors.blue },
	markdownLinkText = { fg = colors.blue, underline = true },
	markdownIdDeclaration = { fg = colors.blue },
	markdownId = { fg = colors.yellow },
	markdownIdDelimiter = { fg = colors.yellow },
	markdownEscape = { fg = colors.cyan },
	markdownError = { fg = colors.red },
	markdownItalic = { italic = true },
	markdownBold = { bold = true },
	markdownBoldItalic = { bold = true, italic = true },
	markdownFootnote = { fg = colors.yellow },
	markdownFootnoteDefinition = { fg = colors.yellow },

	-- Snacks (input)
	SnacksInput = { fg = colors.fg, bg = colors.bg },
	SnacksInputBorder = { fg = colors.dark_yellow, bg = colors.bg },
	SnacksInputTitle = { fg = colors.magenta, bg = colors.bg, bold = true },
	SnacksInputNormal = { fg = colors.fg, bg = colors.bg },

	-- Rainbow Delimiters
	RainbowDelimiterRed = { fg = colors.red },
	RainbowDelimiterYellow = { fg = colors.yellow },
	RainbowDelimiterBlue = { fg = colors.blue },
	RainbowDelimiterOrange = { fg = colors.bright_red },
	RainbowDelimiterGreen = { fg = colors.green },
	RainbowDelimiterViolet = { fg = colors.magenta },
	RainbowDelimiterCyan = { fg = colors.cyan },

	-- Neogit
	NeogitNotificationInfo = { fg = colors.blue },
	NeogitNotificationWarning = { fg = colors.yellow },
	NeogitNotificationError = { fg = colors.red },
	NeogitBranch = { fg = colors.magenta, bold = true },
	NeogitRemote = { fg = colors.blue },
	NeogitUnmergedInto = { fg = colors.green },
	NeogitUnpulledFrom = { fg = colors.red },
	NeogitObjectId = { fg = colors.dark_yellow },
	NeogitStash = { fg = colors.cyan },
	NeogitCursorLine = { bg = colors.dark_bg },
	NeogitHunkHeader = { fg = colors.bg, bg = colors.blue },
	NeogitHunkHeaderHighlight = { fg = colors.bg, bg = colors.magenta },
	NeogitDiffAdd = { fg = colors.green, bg = colors.diff_add },
	NeogitDiffDelete = { fg = colors.red, bg = colors.diff_delete },
	NeogitDiffContextHighlight = { bg = colors.light_bg },
	NeogitDiffAddHighlight = { fg = colors.green, bg = colors.diff_add },
	NeogitDiffDeleteHighlight = { fg = colors.red, bg = colors.diff_delete },
	NeogitSectionHeader = { fg = colors.yellow, bold = true },

	-- Fugitive
	fugitiveHeading = { fg = colors.yellow, bold = true },
	fugitiveUntrackedHeading = { fg = colors.cyan, bold = true },
	fugitiveUnstagedHeading = { fg = colors.red, bold = true },
	fugitiveStagedHeading = { fg = colors.green, bold = true },
	fugitiveHelpTag = { fg = colors.blue },

	-- FFF
	FffNormal = { fg = colors.fg, bg = colors.bg },
	FffBorder = { fg = colors.dark_yellow, bg = colors.bg },
	FffTitle = { fg = colors.magenta, bg = colors.bg, bold = true },
	FffCursorLine = { fg = colors.bg, bg = colors.blue },
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
