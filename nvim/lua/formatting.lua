-- null-ls setup
local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup({
  debug = true,
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
  sources = {
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.prismaFmt,
    null_ls.builtins.formatting.stylua,
  },
})

-- prettier setup
local status, prettier = pcall(require, "prettier")
if not status then
  return
end

prettier.setup({
  bin = "prettierd",
  filetypes = {
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "scss",
    "less",
  },
})
