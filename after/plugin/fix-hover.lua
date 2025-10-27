-- Fix LSP hover float: remove colorcolumn
vim.api.nvim_create_autocmd("LspAttach", {
  once = true,
  callback = function()
    vim.defer_fn(function()
      local ok, _ = pcall(require, "lspconfig")
      if not ok then return end

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {
          style = "minimal",     -- THIS REMOVES colorcolumn
          border = "rounded",
          focusable = true,
        }
      )
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { style = "minimal", border = "rounded" }
      )
    end, 200)
  end,
})
