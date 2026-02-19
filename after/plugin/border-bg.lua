-- Remove background color from border drawing characters
-- This runs after plugins are loaded to override their highlight settings

local function clear_border_bg()
	local border_hl_groups = {
		"FloatBorder",
		"WinSeparator",
		"VertSplit",
		"NormalFloat",
		"NeoTreeFloatBorder",
		"NeoTreeNormalFloat",
		"LspSignatureActiveParameter",
		"LspFloatWinBorder",
		"DiagnosticFloatBorder",
		"TelescopeBorder",
		"FzfLuaBorder",
		"WhichKeyBorder",
		"CmpDocumentationBorder",
		"CmpWindowBorder",
		"BlinkCmpDocBorder",
		"BlinkCmpMenuBorder",
		"NoiceCmdlinePopupBorder",
		"NoiceCmdlinePopupBorderSearch",
		"NoiceMini",
		"NotifyBackground",
		"NotifyBorder",
		"SnacksInputBorder",
		"SnacksNormal",
	}

	for _, hl in ipairs(border_hl_groups) do
		local ok, hl_def = pcall(vim.api.nvim_get_hl, 0, { name = hl })
		if ok and hl_def then
			vim.api.nvim_set_hl(0, hl, vim.tbl_extend("force", hl_def, { bg = "none" }))
		end
	end
end

-- Run after colorscheme is loaded
vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("ClearBorderBg", { clear = true }),
	callback = clear_border_bg,
})

-- Also run immediately in case colorscheme is already set
vim.schedule(clear_border_bg)
