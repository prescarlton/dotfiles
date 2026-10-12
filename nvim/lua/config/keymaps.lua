-- editor keymaps. plugin keymaps live in each plugin spec's `keys` table.
local map = vim.keymap.set

-- no yank with x
map("n", "x", '"_x')

-- increment / decrement
map("n", "+", "<C-a>")
map("n", "-", "<C-x>")

-- delete a word (backwards, without yanking)
map("n", "dw", 'vb"_d')

-- select all
map("n", "<C-a>", "gg<S-v>G")

-- tabs / splits
map("n", "te", "<Cmd>tabedit<CR>", { silent = true })
map("n", "ss", "<Cmd>split<CR><C-w>w", { silent = true })
map("n", "sv", "<Cmd>vsplit<CR><C-w>W", { silent = true })

-- control windows
map("n", "<Space>", "<C-w>w")
map("", "<leader>wh", "<C-w>h")
map("", "<leader>wl", "<C-w>l")
map("", "<leader>wj", "<C-w>j")
map("", "<leader>wk", "<C-w>k")

-- lsp / diagnostics (0.11+ already provides grn, gra, grr, gri, gO, K)
map("n", "<leader>d", function() vim.diagnostic.open_float({ focusable = false }) end, { desc = "Line diagnostics" })
map("n", "<leader>h", vim.lsp.buf.hover, { desc = "Hover" })
