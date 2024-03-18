local wezterm = require("wezterm")
local config = {}

-- font shtuff
-- config.font = wezterm.font("JetBrains Mono", { weight = "Medium" })
config.font = wezterm.font("Monaspace Neon", {
  weight = "Medium",
})
config.font_size = 16.0
config.line_height = 1.1
config.harfbuzz_features = { "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08", "calt", "dlig" }

--window styling
config.window_decorations = "RESIZE"

-- config.color_scheme = "AyuMirage (Gogh)"
-- config.color_scheme = "OneDark (Gogh)"
-- config.color_scheme = "Breath (Gogh)"
config.color_scheme = "CustomScheme"
config.color_schemes = {
  ["CustomScheme"] = {
    -- Foreground, background, and cursor colors
    foreground = "#C8D0E0",
    background = "#282C34",
    cursor_bg = "#C8D0E0",
    cursor_border = "#C8D0E0",
    cursor_fg = "#2E3440",

    -- ANSI colors
    ansi = { "#3B4252", "#BF616A", "#A3BE8C", "#EBCB8B", "#81A1C1", "#B988B0", "#88C0D0", "#E5E9F0" },
    brights = { "#4C566A", "#D57780", "#8FBCBB", "#ECEFF4", "#5E81AC", "#B48EAD", "#96B5B4", "#8FBCBB" },

    -- Indexed colors
    indexed = { [136] = "#D08F70", [175] = "#E85B7A" },

    -- Other colors (optional, remove if not needed)
    selection_bg = "#4C566A",
    selection_fg = "#E5E9F0",
  },
}

-- tab bar setup
config.use_fancy_tab_bar = false
config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    background = "#2E3440",

    -- The active tab is the one that has focus in the window
    active_tab = {
      bg_color = "#4C566A",
      fg_color = "#E5E9F0",
    },

    -- Inactive tabs are the ones that are not in focus
    inactive_tab = {
      bg_color = "#3B4252",
      fg_color = "#646A76",
    },

    -- You can also style the hover state of inactive tabs
    inactive_tab_hover = {
      bg_color = "#434C5E",
      fg_color = "#A3BE8C",
      italic = false,
      underline = "None",
    },

    -- The new tab button that lets you open new tabs
    new_tab = {
      bg_color = "#2E3440",
      fg_color = "#E5E9F0",
    },

    -- Styling when the new tab button is hovered
    new_tab_hover = {
      bg_color = "#3B4252",
      fg_color = "#88C0D0",
      italic = false,
      underline = "None",
    },
  },
}

-- status bar
wezterm.on("update-right-status", function(window, pane)
  local cwd = " " .. pane:get_current_working_dir():sub(8) .. " "
  local fmt_cwd = cwd:gsub("prestons%-mackbook%-pro.local/Users/presto", "~")
  local date = wezterm.strftime(" %I:%M %p %m/%d/%y ")
  local hostname = " " .. wezterm.hostname() .. " "

  window:set_right_status(wezterm.format({
    { Foreground = { Color = "#4C566A" } }, -- Adjusted color
    { Text = "" },
  }) .. wezterm.format({
    { Foreground = { Color = "#88C0D0" } }, -- Adjusted color
    { Background = { Color = "#4C566A" } }, -- Adjusted color
    { Text = fmt_cwd },
  }) .. wezterm.format({
    { Foreground = { Color = "#81A1C1" } }, -- Adjusted color
    { Background = { Color = "#4C566A" } }, -- Adjusted color
    { Text = "" },
  }) .. wezterm.format({
    { Foreground = { Color = "#2E3440" } }, -- Adjusted color
    { Background = { Color = "#81A1C1" } }, -- Adjusted color
    { Text = date },
  }) .. wezterm.format({
    { Foreground = { Color = "#88C0D0" } }, -- Adjusted color
    { Background = { Color = "#81A1C1" } }, -- Adjusted color
    { Text = "" },
  }) .. wezterm.format({
    { Foreground = { Color = "#2E3440" } }, -- Adjusted color
    { Background = { Color = "#88C0D0" } }, -- Adjusted color
    { Text = hostname },
  }))
end)

-- set them keys up big dog
config.keys = {
  -- Switch to next tab
  { key = "]", mods = "SUPER", action = wezterm.action({ ActivateTabRelative = 1 }) },
  -- Switch to previous tab
  { key = "[", mods = "SUPER", action = wezterm.action({ ActivateTabRelative = -1 }) },
}

return config
