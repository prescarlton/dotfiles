-- server configs come from nvim-lspconfig's lsp/*.lua, with my overrides in
-- the top-level lsp/ dir; servers are started via vim.lsp.enable().
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      vim.lsp.config("*", {
        capabilities = require("blink.cmp").get_lsp_capabilities(),
      })

      -- installs servers and calls vim.lsp.enable() on everything mason has
      -- (rust_analyzer is left to rustaceanvim, omnisharp to csharp.nvim).
      -- gopls isn't listed since it needs a go toolchain; `brew install go` then
      -- `:MasonInstall gopls` and it gets enabled automatically.
      require("mason-lspconfig").setup({
        ensure_installed = {
          "biome",
          "cssls",
          "cssmodules_ls",
          "eslint",
          "lua_ls",
          "prismals",
          "pyright",
          "tailwindcss",
          "terraformls",
          "vtsls",
        },
        automatic_enable = { exclude = { "rust_analyzer", "omnisharp", "ts_ls" } },
      })

      -- built-in color swatches for tailwind/css colors
      vim.lsp.document_color.enable(true, nil, { style = "virtual" })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client or client.name ~= "eslint" then return end
          -- Own the whole JS/TS save pipeline here so it runs in a fixed order:
          -- 1. ESLint autofix (sorts imports via simple-import-sort, synchronous) …
          -- 2. … then Prettier, which preserves the now-sorted import order.
          -- conform's format_on_save deliberately skips these filetypes so the two
          -- don't race on BufWritePre and drop the ESLint edit on a version mismatch.
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = args.buf,
            group = vim.api.nvim_create_augroup("user_eslint_" .. args.buf, { clear = true }),
            callback = function()
              vim.cmd("LspEslintFixAll")
              require("conform").format({ bufnr = args.buf, lsp_format = "fallback", timeout_ms = 500 })
            end,
          })
        end,
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
    opts = {},
  },

  -- lua_ls types for the nvim api + plugins
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
}
