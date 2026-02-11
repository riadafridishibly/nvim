-- Create a helper for consistent floating window config
-- local float_opts = {
--   border = "rounded",            -- rounded border
--   style = "minimal",             -- no extra decorations
--   relative = "editor",           -- position relative to entire editor
--   width = math.floor(vim.o.columns * 0.8),
--   height = math.floor(vim.o.lines * 0.8),
--   row = math.floor(vim.o.lines * 0.1),
--   col = math.floor(vim.o.columns * 0.1),
-- }

-- Match the background color of the main window
-- You can tweak this with your preferred highlight groups
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal", })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#666666", bg = "none" })

-- Neo-tree highlight improvements
-- Make the selected file more visible with a distinct background
vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "#3b4261", bold = true, })
-- Make file names on the selected line stand out
vim.api.nvim_set_hl(0, "NeoTreeFileNameOpened", { fg = "#61afef", bold = true, })
-- Make directory names slightly dimmed
vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#a9b1d6", })

-- -- Example: open a demo floating window
-- vim.keymap.set("n", "<leader>f", function()
--   local buf = vim.api.nvim_create_buf(false, true)
--   vim.api.nvim_open_win(buf, true, float_opts)
--   vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Hello from float!" })
-- end, { desc = "Open floating window" })
--
-- after/plugin/float.lua
