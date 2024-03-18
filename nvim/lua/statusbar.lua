-- config for the statusbar. atm, this is lualine

-- integrate spotify
local status = require("nvim-spotify").status
status:start()

require("lualine").setup({
  sections = {
    lualine_x = {
      status.listen,
    },
  },
})
