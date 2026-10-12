local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("user", { clear = true })

-- restore the terminal's underline cursor when leaving nvim
autocmd("VimLeave", {
  group = group,
  command = "set guicursor=a:hor25,a:blinkon10",
})

autocmd("TermOpen", {
  group = group,
  command = "setlocal nonumber norelativenumber",
})

-- poor man's vim-rooter: lcd into the project root, preferring turbo
-- monorepo roots (majority of my projects) over the nearest .git
autocmd("BufEnter", {
  group = group,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then return end
    local root = vim.fs.root(args.buf, { "turbo.json", ".git" })
    if root and root ~= vim.fn.getcwd(0) then vim.cmd.lcd(root) end
  end,
})
