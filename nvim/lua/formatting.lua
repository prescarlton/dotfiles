-- Biome when the project has a biome.json (format + import sort + tailwind class
-- sort via `biome check --write`), otherwise prettier.
local web = { "biome-check", "prettier", stop_after_first = true }

require("conform").setup({
  formatters_by_ft = {
    javascript = web,
    typescript = web,
    typescriptreact = web,
    javascriptreact = web,
    json = web,
    jsonc = web,
    css = web,
    scss = { "prettier" },
    lua = { "stylua" },
    java = { "google-java-format" },

  },
  formatters = {
    -- only "available" inside a biome project, so other projects fall through to prettier
    ["biome-check"] = { require_cwd = true },
  },
  format_on_save = function(bufnr)
    -- When ESLint is attached, its on_attach hook in lsp.lua owns the JS/TS save:
    -- EslintFixAll (import sort) followed by conform.format() in a fixed order.
    -- Skipping them here avoids a competing BufWritePre that would clobber the
    -- ESLint autofix. Without ESLint (e.g. biome projects) conform handles it.
    local handled_by_eslint = {
      javascript = true,
      javascriptreact = true,
      typescript = true,
      typescriptreact = true,
    }
    if
      handled_by_eslint[vim.bo[bufnr].filetype]
      and #vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" }) > 0
    then
      return
    end
    return {
      -- first biome spawn can take longer than 500ms
      timeout_ms = 2000,
      lsp_format = "fallback",
    }
  end,
})
