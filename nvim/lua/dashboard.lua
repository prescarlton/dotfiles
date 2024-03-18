local alpha = require("alpha")
local base_theme = require("alpha.themes.dashboard")

-- slam that header together
base_theme.section.header.val = {
  "deez nuts",
}

-- setup menu
base_theme.section.buttons.val = {
  base_theme.button("r", "recently used", ":Telescope oldfiles <CR>"),
  base_theme.button("u", "󰚰 update packages", ":PackerUpdate <CR>"),
  base_theme.button("f", " find files", ":Telescope find_files <CR>"),
  base_theme.button("g", " find string", ":Telescope live_grep <CR>"),
  base_theme.button("d", "dotfiles", ":execute 'cd ~/.config' | :Telescope file_browser <CR>"),
  base_theme.button("q", "quit", ":qa<CR>"),
}

alpha.setup(base_theme.opts)
