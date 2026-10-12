-- snacks: picker (telescope replacement), explorer, dashboard, terminal, notifier
local exclude = {
  ".git",
  "node_modules",
  "build",
  "dist",
  ".output",
  ".next",
  "ios",
  "android",
}

-- show hidden + gitignored files (e.g. .env), minus the usual junk
local search = { hidden = true, ignored = true, exclude = exclude }

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      words = { enabled = true },
      explorer = { enabled = true, replace_netrw = true },
      picker = {
        enabled = true,
        ui_select = true,
        sources = {
          files = search,
          grep = search,
          explorer = {
            hidden = true,
            ignored = true,
            exclude = { "node_modules" },
            layout = { layout = { position = "left", width = 40 } },
          },
        },
        win = {
          input = { keys = { ["q"] = { "close", mode = "n" } } },
        },
      },
      dashboard = {
        enabled = true,
        preset = {
          header = "nvim",
          keys = {
            { key = "r", desc = "recently used", action = ":lua Snacks.picker.recent()" },
            { key = "f", desc = "find files", action = ":lua Snacks.picker.files()" },
            { key = "g", desc = "find string", action = ":lua Snacks.picker.grep()" },
            { key = "d", desc = "dotfiles", action = ":lua Snacks.picker.files({ cwd = '~/dotfiles' })" },
            { key = "u", desc = "update packages", action = ":Lazy update" },
            { key = "q", desc = "quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
        },
      },
      terminal = { win = { style = "terminal" } },
    },
    keys = {
      -- find
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
      { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>fs", function() Snacks.picker.grep_word() end, desc = "Grep word", mode = { "n", "x" } },
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>ft", function() Snacks.picker.help() end, desc = "Help tags" },
      { "<leader>fc", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>fp", function() Snacks.picker.resume() end, desc = "Resume last picker" },

      -- lsp
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto definition" },
      { "gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto type definition" },
      { "gp", function() Snacks.picker.lsp_definitions({ auto_confirm = false }) end, desc = "Peek definition" },
      { "<leader>fr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },

      -- explorer
      { "<leader>b", function() Snacks.explorer() end, desc = "File explorer" },
      {
        "<leader>sf",
        function() Snacks.explorer({ cwd = vim.fn.expand("%:p:h") }) end,
        desc = "Explorer at buffer dir",
      },

      -- terminals
      { "<leader>tf", function() Snacks.terminal.toggle() end, mode = { "n", "t" }, desc = "Floating terminal" },
      {
        "<leader>tj",
        function() Snacks.terminal.toggle(nil, { win = { position = "bottom" } }) end,
        desc = "Bottom terminal",
      },

      { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification history" },
    },
  },
}
