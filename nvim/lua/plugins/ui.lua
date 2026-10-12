return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- cute command popups
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = { enabled = true },
        -- use treesitter markdown rendering for hover docs
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        -- blink.cmp handles signature help
        signature = { enabled = false },
        message = { enabled = true },
      },
      presets = {
        bottom_search = true, -- classic bottom cmdline for search
        command_palette = true, -- cmdline and popupmenu together
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  -- breadcrumbs in the winbar
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      {
        "<leader>l",
        function() require("dropbar.api").pick(vim.v.count ~= 0 and vim.v.count or nil) end,
        desc = "Pick breadcrumb",
      },
    },
  },

  -- diagnostics list
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
      { "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (workspace)" },
      { "<leader>xw", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (workspace)" },
      { "<leader>xd", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Diagnostics (buffer)" },
      { "<leader>xq", "<Cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
      { "<leader>xl", "<Cmd>Trouble loclist toggle<CR>", desc = "Location list" },
      { "gR", "<Cmd>Trouble lsp_references toggle<CR>", desc = "LSP references (trouble)" },
    },
  },
}
