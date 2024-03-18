-- config for terminal

local term = require("terminal").terminal:new({
  autoclose = true,
})

vim.keymap.set("n", "<leader>tj", function()
  term:open({ open_cmd = "botright new" })
end)
vim.keymap.set("n", "<leader>tw", function()
  term:open({ open_cmd = "enew" })
end)
