-- i believe this sets up autocmds to reset cursor
-- whenever you close nvim. not really sure though tbh
local api = vim.api

api.nvim_create_autocmd("VimLeave", {
  pattern = "*",
  command = [[ set guicursor=a:hor25,a:blinkon10 ]],
})
-- augroup term
--   autocmd!
--   autocmd TermOpen * setlocal nonumber norelativenumber
--   augroup END

api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = [[ setlocal nonumber norelativenumber ]],
})
