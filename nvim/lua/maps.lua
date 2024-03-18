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
