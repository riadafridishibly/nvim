-- Neovim configuration (inspired by jonhoo’s setup)
-- https://github.com/jonhoo/configs/blob/master/editor/.config/nvim/init.lua

-- Set <Space> as leader key
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "

-------------------------------------------------------------------------------
-- Preferences
-------------------------------------------------------------------------------

vim.opt.foldenable = false
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99

vim.opt.formatoptions = "tcrqnb"
vim.opt.scrolloff = 2
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.opt.swapfile = false

-- Wildmenu and ignore patterns
vim.opt.wildmode = "list:longest"
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"
vim.o.winborder = 'rounded'

-- Tabs and indentation
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Misc
vim.opt.vb = true
vim.opt.diffopt:append({ "iwhite", "algorithm:histogram", "indent-heuristic" })
-- vim.opt.colorcolumn = "80"
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"
-- vim.opt.list = true

vim.api.nvim_create_autocmd("Filetype", { pattern = "rust", command = "set colorcolumn=100" })

-------------------------------------------------------------------------------
-- Keymaps
-------------------------------------------------------------------------------

-- File/buffer operations
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>;", "<cmd>Buffers<cr>")
vim.keymap.set("n", "<leader>o", ':e <C-R>=expand("%:p:h") . "/" <cr>')
vim.keymap.set("n", "<leader><leader>", "<c-^>")

-- Navigation
vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "$")
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move down window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move up window" })

-- Search and regex
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("n", "?", "?\\v")

-- Utility
vim.keymap.set("n", "<leader>,", ":set invlist<cr>")
vim.keymap.set("n", "<leader>m", "ct_")
vim.keymap.set("", "<F1>", "<Esc>")
vim.keymap.set("i", "<F1>", "<Esc>")

-- Disable arrow keys
for _, mode in ipairs({ "n", "i" }) do
	vim.keymap.set(mode, "<up>", "<nop>")
	vim.keymap.set(mode, "<down>", "<nop>")
end
vim.keymap.set("n", "<left>", ":bp<cr>")
vim.keymap.set("n", "<right>", ":bn<cr>")
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")



-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Formatting
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

-------------------------------------------------------------------------------
-- Diagnostics
-------------------------------------------------------------------------------

vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

-------------------------------------------------------------------------------
-- Autocommands
-------------------------------------------------------------------------------

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_user_command("Mkdir", function()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" then
		print("No file name; cannot create directory.")
		return
	end

	local dir = vim.fn.fnamemodify(file, ":p:h")

	if vim.fn.isdirectory(dir) == 1 then
		print("Directory already exists: " .. dir)
		return
	end

	vim.fn.mkdir(dir, "p")
	print("Created directory: " .. dir)
end, {})

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") and not vim.fn.expand("%:p"):find(".git", 1, true) then
			vim.cmd('normal! g`"')
		end
	end,
})

-- Read-only for special files
vim.api.nvim_create_autocmd("BufRead", { pattern = { "*.orig", "*.pacnew" }, command = "set readonly" })

-- Leave paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set nopaste" })

-- Shorter text widths for prose
local text = vim.api.nvim_create_augroup("text", { clear = true })
for _, pat in ipairs({ "text", "mail", "gitcommit" }) do
	vim.api.nvim_create_autocmd("Filetype",
		{ pattern = pat, group = text, command = "setlocal spell tw=72 colorcolumn=73" })
end

vim.api.nvim_create_autocmd("Filetype", {
	pattern = { "tex", "markdown" },
	group = text,
	callback = function()
		-- Only apply to modifiable buffers, not LSP hover (which is nomodifiable)
		if vim.bo.modifiable then
			vim.opt_local.spell = true
			vim.opt_local.textwidth = 80
			vim.opt_local.colorcolumn = "81"
		end
	end,
})

-- Treat *.slide files as markdown
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.slide",
	callback = function() vim.bo.filetype = "markdown" end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "Podfile",
	callback = function() vim.bo.filetype = "ruby" end,
})

if vim.g.neovide then
	vim.g.gui_font_default_size = 12
	vim.g.gui_font_size = vim.g.gui_font_default_size
	vim.g.gui_font_face = "JetBrainsMonoNL NFM Light"

	RefreshGuiFont = function()
		vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
	end

	ResizeGuiFont = function(delta)
		vim.g.gui_font_size = vim.g.gui_font_size + delta
		RefreshGuiFont()
	end

	ResetGuiFont = function()
		vim.g.gui_font_size = vim.g.gui_font_default_size
		RefreshGuiFont()
	end

	-- Call function on startup to set default value
	ResetGuiFont()

	-- Keymaps

	-- local opts = { noremap = true, silent = true }

	vim.g.neovide_opacity = 0.99
	vim.g.neovide_cursor_vfx_mode = 'pixiedust'
	vim.g.neovide_normal_opacity = 0.99
	vim.g.neovide_scroll_animation_length = 0.25

	vim.keymap.set('', '<D-=>', function() ResizeGuiFont(1) end,
		{ desc = 'Zoom in Neovide', noremap = true, silent = true })
	vim.keymap.set('', '<D-->', function() ResizeGuiFont(-1) end,
		{ desc = 'Zoom out Neovide', noremap = true, silent = true })
	vim.keymap.set('', '<D-0>', function() ResetGuiFont() end,
		{ desc = 'Reset Neovide zoom', noremap = true, silent = true })
end

-------------------------------------------------------------------------------
-- Plugin Setup (lazy.nvim)
-------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath })
end
vim.opt.rtp:prepend(lazypath)



vim.opt.guicursor = {
	"n-v-c:block", -- Normal/visual/command mode: block
	"i-ci:ver25", -- Insert and command-insert: vertical bar
	"r-cr:hor20", -- Replace modes: underline
	"o:hor50",  -- Operator-pending: thick underline
	"c:ver20",
	-- "a:blinkon0,		-- Disable blinking
}

vim.api.nvim_create_autocmd("VimLeave", {
	group = vim.api.nvim_create_augroup("Exit", { clear = true }),
	command = "set guicursor=a:ver90",
	desc = "Set cursor back to beam when leaving Neovim."
})


-- Command to trim trailing spaces
vim.api.nvim_create_user_command("TrimTrailingSpaces", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd([[%s/\s\+$//e]])
	vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Remove trailing spaces from the buffer" })

require("lazy").setup({
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			input = { enabled = true },
			-- Responsible for creating input box near cursor
			styles = { input = { relative = "cursor" } }
		},
	},

	{
		'sainnhe/gruvbox-material',
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.gruvbox_material_enable_italic = true
			vim.cmd.colorscheme('gruvbox-material')
		end
	},
	-- Indentation guides
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({ indent = { char = "▏" } })
		end,
	},
	-- {
	-- 	'saghen/blink.indent',
	-- 	--- @module 'blink.indent'
	-- 	--- @type blink.indent.Config
	-- 	opts = {
	-- 		static = {
	-- 			enabled = true,
	-- 			char = '▏',
	-- 			whitespace_char = nil, -- inherits from `vim.opt.listchars:get().space` when `nil` (see `:h listchars`)
	-- 			priority = 1,
	-- 			highlights = { 'BlinkIndent' },
	-- 		},
	-- 		scope = {
	-- 			enabled = true,
	-- 			char = '▏',
	-- 			priority = 1000,
	-- 			highlights = { 'BlinkIndentOrange', 'BlinkIndentViolet', 'BlinkIndentBlue' },
	-- 			-- enable to show underlines on the line above the current scope
	-- 			underline = {
	-- 				enabled = false,
	-- 				highlights = { 'BlinkIndentOrangeUnderline', 'BlinkIndentVioletUnderline', 'BlinkIndentBlueUnderline' },
	-- 			},
	-- 		},
	-- 	},
	-- },

	-- Smooth scrolling
	{
		"karb94/neoscroll.nvim",
		config = function() require("neoscroll").setup({ duration_multiplier = 0.4 }) end,
	},

	{
		'nvim-mini/mini.statusline',
		version = false,
		config = function()
			require 'mini.statusline'.setup {}
		end
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vim", "vimdoc", "typescript", "javascript", "go", "c" },
				highlight = {
					enable = true,
					disable = function(_, buf)
						local max = 100 * 1024
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						return ok and stats and stats.size > max
					end,
				},
			})
		end,
	},

	-- Root detection
	-- { "notjedi/nvim-rooter.lua", config = function() require("nvim-rooter").setup() end },

	-- File explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
		lazy = false,
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				filesystem = {
					filtered_items = {
						visible = true,
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					follow_current_file = { enabled = true },
				},
			})

			vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>")
		end,
	},


	-- Fuzzy finder
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local fzflua = require("fzf-lua")
			fzflua.setup({
				"ivy",
				codeaction = {
					diff_opts = { ctxlen = 3 },
				},
				codeaction_native = {
					diff_opts = { ctxlen = 3 },
				},
				winopts = {
					border = "rounded",
					preview = { layout = "vertical", vertical = "up:60%" },
				},
				keymap = {
					fzf = {
						["ctrl-q"] = "select-all+accept",
					}
				}
			})

			fzflua.register_ui_select()

			vim.keymap.set("", "<leader>fw", fzflua.live_grep_native)
			vim.keymap.set("", "<leader>fb", fzflua.buffers)
			vim.keymap.set("", "<leader>f/", fzflua.lgrep_curbuf)
			vim.keymap.set("", "<leader>fz", fzflua.resume, { desc = "Resume last fzf-lua" })
			vim.keymap.set("", "gra", fzflua.lsp_code_actions, { desc = "Document codeaction" })
			vim.keymap.set("", "<leader>la", fzflua.lsp_code_actions, { desc = "Document codeaction" })
			vim.keymap.set("n", "<leader>ld", fzflua.lsp_document_diagnostics,
				{ desc = "Document diagnostics (fzf-lua)" })
			vim.keymap.set("n", "<leader>lD", fzflua.lsp_workspace_diagnostics,
				{ desc = "Workspace diagnostics (fzf-lua)" })
			vim.keymap.set("n", "<leader>lr", fzflua.lsp_references, { desc = "LSP references (fzf-lua)" })
			vim.keymap.set("n", "grr", fzflua.lsp_references, { desc = "LSP references (fzf-lua)" })
			vim.keymap.set("n", "<leader>li", fzflua.lsp_implementations, { desc = "LSP implementations (fzf-lua)" })

			vim.keymap.set("n", "<leader>gm", function()
				vim.fn.system("git rev-parse --is-inside-work-tree")
				if vim.v.shell_error ~= 0 then
					vim.notify("Not a git repository", vim.log.levels.WARN)
					return
				end

				fzflua.fzf_exec(
					"{ git diff --name-only HEAD 2>/dev/null; git ls-files --others --exclude-standard; } | sort -u",
					{
						prompt = "Git Modified> ",
						preview = "git diff HEAD -- {1} 2>/dev/null",
						actions = {
							["default"] = function(selected)
								if not selected or #selected == 0 then return end
								local file = selected[1]
								local abs_path = vim.fn.fnamemodify(file, ":p")

								vim.cmd("tabnew " .. vim.fn.fnameescape(abs_path))
								local file_win = vim.api.nvim_get_current_win()
								vim.cmd("diffthis")

								vim.fn.system("git ls-files --error-unmatch " .. vim.fn.shellescape(file))
								if vim.v.shell_error ~= 0 then
									-- Untracked file: diff against empty buffer
									vim.cmd("leftabove vnew")
									vim.bo.buftype = "nofile"
									vim.bo.bufhidden = "wipe"
									vim.bo.filetype = vim.filetype.match({ filename = abs_path }) or ""
									vim.cmd("diffthis")
								else
									-- Tracked file: diff against HEAD
									local git_content =
										vim.fn.systemlist("git show HEAD:" .. vim.fn.shellescape(file))
									vim.cmd("leftabove vnew")
									vim.bo.buftype = "nofile"
									vim.bo.bufhidden = "wipe"
									vim.bo.filetype = vim.filetype.match({ filename = abs_path }) or ""
									vim.api.nvim_buf_set_lines(0, 0, -1, false, git_content)
									vim.bo.modifiable = false
									vim.cmd("diffthis")
								end
								vim.api.nvim_set_current_win(file_win)
							end,
							["ctrl-e"] = fzflua.actions.file_edit,
						},
					}
				)
			end, { desc = "Git modified files (native diff)" })
		end,
	},

	-- LSP setup
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						gofumpt = true,
						-- staticcheck = true,
						analyses = {
							unusedparams = true,
							-- shadow = true,
						},
					},
				},
			})

			vim.lsp.enable("gopls")

			vim.lsp.config("vtsls", {})
			vim.lsp.enable("vtsls")

			vim.lsp.config['luals'] = {
				-- Command and arguments to start the server.
				cmd = { 'lua-language-server' },
				-- Filetypes to automatically attach to.
				filetypes = { 'lua' },
				-- Sets the "workspace" to the directory where any of these files is found.
				-- Files that share a root directory will reuse the LSP server connection.
				-- Nested lists indicate equal priority, see |vim.lsp.Config|.
				root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
				-- Specific settings to send to the server. The schema is server-defined.
				-- Example: https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
				-- Make the server aware of Neovim runtime files
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						runtime = {
							version = 'LuaJIT',
						}
					}
				}
			}

			vim.lsp.enable('luals')

			vim.keymap.set("n", "<leader>D", function()
				vim.diagnostic.open_float({ border = "rounded", source = true, severity_sort = true })
			end)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)


			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- also grn
					vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
				end,
			})
		end,
	},

	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				config = function()
					local luasnip = require "luasnip"

					-- Loads all the snippets installed by extensions in vscode.
					-- require('luasnip.loaders.from_vscode').lazy_load()
					require("luasnip.loaders.from_vscode").load { paths = "~/.config/nvim/snippets" }

					luasnip.config.set_config {
						region_check_events = "InsertEnter",
						delete_check_events = "InsertLeave",
					}

					luasnip.config.setup {}
				end,
			},
		},
		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "default",
				-- ["<Tab>"] = { "fallback" },
				-- ["<S-Tab>"] = { "snippet_forward", "fallback" },
			},
			snippets = { preset = "luasnip" },
			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 400,
				},
				ghost_text = {
					enabled = true
				}
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "snippets", "lsp", "path", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- Signature help
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function()
			require("lsp_signature").setup({ doc_lines = 0, handler_opts = { border = "none" } })
		end,
	},

	-- Language support
	{ "hashivim/vim-terraform", ft = "terraform" },
	{ "evanleck/vim-svelte",    ft = "svelte" },
	"cespare/vim-toml",
	{ "cuducos/yaml.nvim", ft = "yaml", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{
		"rust-lang/rust.vim",
		ft = "rust",
		config = function()
			vim.g.rustfmt_autosave = 1
			vim.g.rust_clip_command = "pbcopy"
		end,
	},
	"khaveesh/vim-fish-syntax",
	{
		"plasticboy/vim-markdown",
		ft = "markdown",
		dependencies = { "godlygeek/tabular" },
		config = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_new_list_item_indent = 0
			vim.g.vim_markdown_auto_insert_bullets = 0
		end,
	},
	{
		'dmtrKovalenko/fff.nvim',
		build = function()
			-- this will download prebuild binary or try to use existing rustup toolchain to build from source
			-- (if you are using lazy you can use gb for rebuilding a plugin if needed)
			require("fff.download").download_or_build_binary()
		end,
		-- if you are using nixos
		-- build = "nix run .#release",
		opts = {        -- (optional)
			debug = {
				enabled = true, -- we expect your collaboration at least during the beta
				show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
			},
		},
		-- No need to lazy-load with lazy.nvim.
		-- This plugin initializes itself lazily.
		lazy = false,
		keys = {
			{
				"ff", -- try it if you didn't it is a banger keybinding for a picker
				function() require('fff').find_files() end,
				desc = 'FFFind files',
			},
			{
				"<leader>ff", -- try it if you didn't it is a banger keybinding for a picker
				function() require('fff').find_files() end,
				desc = 'FFFind files',
			},
		}
	},
	{
		'xiyaowong/transparent.nvim',
		lazy = false,
	},
	-- {
	-- 	"riadafridishibly/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {},
	-- }
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false, -- No lazy plz for this
	},
	{
		'mikesmithgh/kitty-scrollback.nvim',
		enabled = true,
		lazy = true,
		cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth', 'KittyScrollbackGenerateCommandLineEditing' },
		event = { 'User KittyScrollbackLaunch' },
		-- version = '*', -- latest stable version, may have breaking changes if major version changed
		-- version = '^6.0.0', -- pin major version, include fixes and features that do not have breaking changes
		config = function()
			require('kitty-scrollback').setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {}
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {}
	},
	{
		"A7Lavinraj/fyler.nvim",
		dependencies = { "nvim-mini/mini.icons" },
		lazy = false, -- Necessary for `default_explorer` to work properly
		opts = {}
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"ibhagwan/fzf-lua", -- optional
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
		}
	},
	-- {
	-- 	'MeanderingProgrammer/render-markdown.nvim',
	-- 	dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	-- 	---@module 'render-markdown'
	-- 	---@type render.md.UserConfig
	-- 	opts = {},
	-- }
})
