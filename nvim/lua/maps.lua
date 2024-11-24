local keymap = vim.keymap

-- no yank with x
keymap.set("n", "x", '"_x')

-- increment / decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<c-x>")

-- delete a word
keymap.set("n", "dw", 'vb"_d')

-- select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- new tab
keymap.set("n", "te", ":tabedit<Return>", { silent = true })
-- split window
keymap.set("n", "ss", ":split<Return><C-w>w", { silent = true })
keymap.set("n", "sv", ":vsplit<Return><C-w>W", { silent = true })

-- control windows
keymap.set("n", "<Space>", "<C-w>w")
keymap.set("", "<leader>wh", "<C-w>h")
keymap.set("", "<leader>wl", "<C-w>l")
keymap.set("", "<leader>wj", "<C-w>j")
keymap.set("", "<leader>wk", "<C-w>k")

keymap.set("", "<leader>b", ":NvimTreeToggle<Return>")

-- copy to system clipboard
-- keymap.set("", "y", '"+y')
-- -- paste from system clipboard
-- keymap.set("", "p", '"+p')


-- dropbar (top bar thingie)
keymap.set("", "<leader>l", function()
  require("dropbar.api").pick(vim.v.count ~= 0 and vim.v.count)
end)

-- Trouble (diagnostics)
vim.keymap.set("n", "<leader>xx", function()
  require("trouble").toggle()
end)
vim.keymap.set("n", "<leader>xw", function()
  require("trouble").toggle("workspace_diagnostics")
end)
vim.keymap.set("n", "<leader>xd", function()
  require("trouble").toggle("document_diagnostics")
end)
vim.keymap.set("n", "<leader>xq", function()
  require("trouble").toggle("quickfix")
end)
vim.keymap.set("n", "<leader>xl", function()
  require("trouble").toggle("loclist")
end)
vim.keymap.set("n", "gR", function()
  require("trouble").toggle("lsp_references")
end)
