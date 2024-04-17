-- setup all git-related plugins
require("gitsigns").setup({})

local status, git = pcall(require, "git")
if not status then
  return
end

git.setup({
  keymaps = {
    blame = "<Leader>gb",
  },
})
-- move the status to the right of the numbers and set its width
vim.opt.numberwidth = 5
vim.opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s"
