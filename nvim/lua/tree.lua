require("nvim-tree").setup({
  view = {
    width = 40,
  },
  git = {
    -- ignore = false,
    enable = true,
  },
  filters = {
    custom = { "^\\node_modules$" },
    exclude = { ".env$", ".env.*$", ".env.*.local$" },
  },
  update_focused_file = {
    enable = true,
  },
})
