-- set the leader to somethin a lil less goofy (must happen before lazy loads)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

local opt = vim.opt

-- setup them cute lil line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 5
-- line number first, then signs (gitsigns/diagnostics) to the right of it
opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} %s"

opt.autoindent = true
opt.smartindent = true

-- spaces r king
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- remove tildes on empty lines
opt.fillchars = { eob = " " }
opt.wrap = false
opt.path:append({ "**" })
opt.shell = "fish"
opt.termguicolors = true
opt.signcolumn = "yes"
opt.completeopt = { "menuone", "noinsert", "noselect" }

-- rounded borders on every floating window (hover, diagnostics, etc.)
opt.winborder = "rounded"

-- block in normal, underline in insert
opt.guicursor = "n-v-c-sm:block,i-ci-ve:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"

-- system clipboard
if vim.fn.has("win32") == 1 then
  opt.clipboard:prepend({ "unnamed", "unnamedplus" })
else
  opt.clipboard:append({ "unnamedplus" })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = { header = "", prefix = "" },
})
