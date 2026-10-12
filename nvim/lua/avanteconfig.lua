local avante = require("avante")
avante.setup({
  -- The default options for the plugin
  opts = {
    -- The default filetypes to enable the plugin on
    -- filetypes = { "markdown", "text", "html", "xml" },
    -- The default keymaps to use
    keymaps = {
      toggle = "<leader>at",
      pick = "<leader>ap",
      select = "<leader>as",
    },
  },
  -- The default settings for the plugin
  settings = {
    -- Whether to enable the plugin by default
    enabled = true,
  },
  windows = {
    input = {
      border = "rounded",
      width = 60,
      height = 10
    },
    ask = {
      floating = true,
      border = "rounded",
      start_insert = true
    }
  },
  provider = "openai",
  providers = {
    openai = {
      model = "o4-mini-2025-04-16",
    }
  }
})
