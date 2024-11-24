-- lsp config
--
local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

local protocol = require("vim.lsp.protocol")

-- typescript setup
-- nvim_lsp.tsserver.setup({
--   filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
--   cmd = { "typescript-language-server", "--stdio" },
-- })
nvim_lsp.vtsls.setup({
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "vtsls", "--stdio" },
})

nvim_lsp.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  cmd = { "vscode-eslint-language-server", "--stdio" },
  filter = function(diag)
    return not (
      (string.find(diag.code or "", "typescript-eslint", 1, true))
      or string.find(diag.code or "", "originalKeywordKind")
    )
  end,
  diagnostics_format = "[eslint] #{m}\n(#{c})",
})
-- prisma setup
nvim_lsp.prismals.setup({})

-- tailwind setup
nvim_lsp.tailwindcss.setup({})
-- lua setup
nvim_lsp.lua_ls.setup({
  Lua = {
    workspace = { checkThirdParty = false },
    telemetry = { enable = false },
  },
})

-- tf setup
nvim_lsp.terraformls.setup({})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- rust setup
nvim_lsp.rust_analyzer.setup({})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.rs" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- python setup
nvim_lsp.pyright.setup({})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.py" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- css setup
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.cssls.setup({
  capabilities = capabilities,
})

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
--   pattern = { "*.css", "*.scss", "*.sass" },
--   callback = function()
--     vim.lsp.buf.format()
--   end,
-- })

--  css modules support in react
nvim_lsp.cssmodules_ls.setup({
  on_attach = function(client, bufnr)
    -- avoid accepting 'definitionProvider' responses from this lsp
    client.server_capabilities.definitionProvider = false
  end,
  -- capabilities = {
  --   definitionProvider = false,
  -- },
  cmd = { "cssmodules-language-server" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "typescriptreact.tsx",
  },
})

-- go setup
nvim_lsp.gopls.setup({
  cmd = { "gopls", "serve" },
})


vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- lspsaga setup. makes the lsp doohickies prettier
--
local saga = require("lspsaga")

saga.setup({
  -- get rid of the goofy ahh lightbulb
  lightbulb = {
    enable = false,
    enable_in_insert = false,
    sign = false,
    sign_priority = 40,
    virtual_text = false,
  },
  server_filetype_map = {
    typescript = "typescript",
  },
})

-- lsp signature setup
require("lsp_signature").setup({
  bind = true,
  hint_enable = false,
})

-- keymaps n whatnot
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
-- show diagnostic window
-- vim.keymap.set("", "<leader>d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("", "<leader>d", function()
  vim.diagnostic.open_float(nil, { focusable = false })
end, opts)
-- show hover menu
vim.keymap.set("", "<leader>h", "<Cmd>Lspsaga hover_doc<CR>", opts)
-- floating terminal that looks cute af
vim.keymap.set("", "<leader>tf", "<Cmd>Lspsaga term_toggle<CR>", opts)
