return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      -- lets blink use nvim-cmp sources
      { "saghen/blink.compat", version = "2.*", opts = {} },
      "pontusk/cmp-sass-variables",
    },
    init = function() vim.g.sass_variables_file = "_variables.scss" end,
    opts = {
      keymap = {
        preset = "none",
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<C-d>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      completion = {
        list = { selection = { preselect = true, auto_insert = false } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = {
          draw = { columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } } },
        },
      },
      signature = { enabled = true },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "sass_variables" },
        providers = {
          lsp = {
            -- drop plain-text suggestions from servers
            transform_items = function(_, items)
              return vim.tbl_filter(
                function(item) return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text end,
                items
              )
            end,
          },
          path = { max_items = 3 },
          buffer = { min_keyword_length = 4, max_items = 3 },
          sass_variables = {
            name = "sass-variables",
            module = "blink.compat.source",
            max_items = 3,
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { disable_filetype = { "snacks_picker_input", "vim" } },
  },
}
