-- merged on top of nvim-lspconfig's lsp/eslint.lua (which provides LspEslintFixAll)
return {
  settings = {
    -- monorepo: resolve each app's eslint config + node_modules separately
    workingDirectories = { mode = "auto" },
    -- ESLint 8.57 server loads the flat-config API only with this opt-in;
    -- required so eslint.config.js/.mjs are read (drop once on ESLint >= 10)
    experimental = { useFlatConfig = true },
  },
}
