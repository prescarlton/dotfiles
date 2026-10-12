return {
  -- rust: manages rust-analyzer itself (don't also enable it via mason-lspconfig)
  {
    "mrcjkb/rustaceanvim",
    version = "^9",
    lazy = false, -- the plugin is already lazy on its own
  },

  -- oml we're actually writing in c# these days (9/27/25), we're making a video game
  {
    "iabdelkareem/csharp.nvim",
    ft = "cs",
    dependencies = {
      "mason-org/mason.nvim", -- installs omnisharp
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim",
    },
    config = function() require("csharp").setup() end,
  },
}
