-- merged on top of nvim-lspconfig's lsp/eslint.lua (which provides LspEslintFixAll)
local flat = {
  "eslint.config.js",
  "eslint.config.mjs",
  "eslint.config.cjs",
  "eslint.config.ts",
  "eslint.config.mts",
  "eslint.config.cts",
}
local legacy = { ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json" }
local config_files = vim.list_extend(vim.list_slice(flat), legacy)

-- ESLint 8.57 only reads flat configs with the experimental opt-in, but forcing it
-- breaks .eslintrc projects ("Could not find config file"). Decide per file from
-- whichever config is closest to it (handles mixed monorepos too).
local function uses_flat_config(fname)
  local found = vim.fs.find(config_files, { path = vim.fs.dirname(fname), upward = true, type = "file", limit = 1 })[1]
  return found ~= nil and vim.fs.basename(found):match("^eslint%.config%.") ~= nil
end

return {
  handlers = {
    -- the server requests settings per document (scopeUri), so answer per document
    ["workspace/configuration"] = function(err, params, ctx)
      local res = vim.lsp.handlers["workspace/configuration"](err, params, ctx)
      for i, item in ipairs(params.items or {}) do
        if item.scopeUri and type(res[i]) == "table" then
          res[i] = vim.deepcopy(res[i])
          res[i].experimental = vim.tbl_extend(
            "force",
            res[i].experimental or {},
            { useFlatConfig = uses_flat_config(vim.uri_to_fname(item.scopeUri)) }
          )
        end
      end
      return res
    end,
  },
}
