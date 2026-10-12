local parsers = {
  "c_sharp",
  "css",
  "fish",
  "go",
  "graphql",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "php",
  "prisma",
  "python",
  "rust",
  "scss",
  "swift",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(args)
          -- no-op for filetypes without an installed parser
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- auto close/rename html + jsx tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = { opts = { enable_close_on_slash = false } },
  },

  -- correct commentstring for tsx/jsx with the built-in `gc`
  { "folke/ts-comments.nvim", event = "VeryLazy", opts = {} },
}
