return {
  {
    "nuvic/flexoki-nvim",
    name = "flexoki",
    lazy = false,
    priority = 1000,
    config = function()
      require("flexoki").setup({
        dim_inactive_windows = false,
        extend_background_behind_borders = false,
        styles = { bold = true, italic = true, transparency = true },
      })
      vim.cmd.colorscheme("flexoki")
    end,
  },
}
