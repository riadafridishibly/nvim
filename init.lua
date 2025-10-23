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
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true

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
vim.opt.colorcolumn = "80"
vim.opt.listchars = "tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•"

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
vim.api.nvim_create_autocmd("Filetype",
	{ pattern = { "tex", "markdown" }, group = text, command = "setlocal spell tw=80 colorcolumn=81" })

-- Treat *.slide files as markdown
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.slide",
	callback = function() vim.bo.filetype = "markdown" end,
})


-------------------------------------------------------------------------------
-- Plugin Setup (lazy.nvim)
-------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			input = { enabled = true },
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
	{ "notjedi/nvim-rooter.lua", config = function() require("nvim-rooter").setup() end },

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
					filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = false },
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
			})

			fzflua.register_ui_select()

			vim.keymap.set("", "<leader>ff", fzflua.files, { desc = "Find files" })
			vim.keymap.set("", "<leader>fw", fzflua.live_grep_native)
			vim.keymap.set("", "<leader>fb", fzflua.buffers)
			vim.keymap.set("", "<leader>f/", fzflua.lgrep_curbuf)
			vim.keymap.set("", "gra", fzflua.lsp_code_actions, { desc = "Document codeaction" })
			vim.keymap.set("", "<leader>la", fzflua.lsp_code_actions, { desc = "Document codeaction" })
			vim.keymap.set("n", "<leader>ld", fzflua.lsp_document_diagnostics,
				{ desc = "Document diagnostics (fzf-lua)" })
			vim.keymap.set("n", "<leader>lD", fzflua.lsp_workspace_diagnostics,
				{ desc = "Workspace diagnostics (fzf-lua)" })
			vim.keymap.set("n", "<leader>lr", fzflua.lsp_references, { desc = "LSP references (fzf-lua)" })
			vim.keymap.set("n", "grr", fzflua.lsp_references, { desc = "LSP references (fzf-lua)" })
			vim.keymap.set("n", "<leader>li", fzflua.lsp_implementations, { desc = "LSP implementations (fzf-lua)" })
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
						staticcheck = true,
						analyses = {
							unusedparams = true,
							shadow = true,
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

	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",

			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")

			local luasnip = require("luasnip")

			-- Make sure LuaSnip is initialized
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").lazy_load()

			local go_snippets = require("snippets.go")
			-- 🔹 Define the iferr snippet for Go
			luasnip.add_snippets("go", go_snippets)


			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},

				preselect = cmp.PreselectMode.Item, -- auto-select first completion item

				-- snippet = { expand = function(args) vim.snippet.expand(args.body) end },
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				experimental = { ghost_text = true },
			})
			cmp.setup.cmdline(":", { sources = cmp.config.sources({ { name = "path" } }) })
		end,
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
	{ "hashivim/vim-terraform",  ft = "terraform" },
	{ "evanleck/vim-svelte",     ft = "svelte" },
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
})
