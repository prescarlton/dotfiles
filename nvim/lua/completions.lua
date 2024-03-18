local status, cmp = pcall(require, "cmp")
if not status then
  return
end
local lspkind = require("lspkind")

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  sources = cmp.config.sources({
    -- { name = "nvim_lsp_signature_help" },
    { name = "codeium" },
    {
      name = "nvim_lsp",
      entry_filter = function(entry, ctx)
        return cmp.lsp.CompletionItemKind.Text ~= entry:get_kind()
      end,
    },
    { name = "path",   max_item_count = 1 },
    { name = "buffer", keyword_length = 4, max_item_count = 1 },
  }),
  formatting = {
    -- format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
      ellipsis_char = "...",
      symbol_map = { Codeium = "" },
    }),
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
