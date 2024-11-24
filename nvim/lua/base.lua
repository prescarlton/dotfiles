-- set the leader to somethin a lil less goofy
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- setup them cute lil line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- remove tildes on empty lines
vim.opt.fillchars = { eob = " " }

-- make tabs not goofy as hell (spaces r king)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
-- expandtab is what actually switches goofy ahh tabs to spaces
vim.opt.expandtab = true
-- setup cursors. no idea how this works honestly, found it online.
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
-- random vim opts
vim.opt.shell = "fish"
-- vim.opt.ignorecase = true
vim.opt.path:append({ "**" }) -- according to craftzdog (the goat), this should include subfolders/files in find files??
vim.opt.wrap = false

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has("macunix")
local is_win = has("win32")

if is_mac then
  require("macos")
end
if is_win then
  require("windows")
end
