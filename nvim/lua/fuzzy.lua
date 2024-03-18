-- config for telescope (fuzzy finder)'

local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and always use filebrowser from telescope
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- insertmode mappings
          ["<C-w>"] = function()
            vim.cmd("normal vbd")
          end,
        },
        ["n"] = {
          -- normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd("startinsert")
          end,
        },
      },
    },
  },
})
telescope.load_extension("file_browser")

-- keymaps
vim.keymap.set("n", "<leader>sf", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = true,
    initial_mode = "normal",
    layout_config = { height = 40 },
  })
end)

vim.keymap.set("n", "<leader>ff", function()
  builtin.find_files({
    hidden = true,
    find_command = {
      "rg",
      "--files",
      "--hidden",
      "--no-ignore-vcs",
      "--glob=!**/.git/*",
      "--glob=!**/node_modules/*",
      "--glob=!**/build/*",
      "--glob=!**/dist/*",
      "--glob=!**/.next/*",
    },
  })
end)
vim.keymap.set("n", "<leader>fg", function()
  builtin.live_grep({
    hidden = true,
    find_command = {
      "rg",
      "--hidden",
      "--no-ignore-vcs",
      "--glob=!**/.git/*",
      "--glob=!**/node_modules/*",
      "--glob=!**/build/*",
      "--glob=!**/dist/*",
      "--glob=**/.env$",
      "--glob=**/.env.*$",
      "--glob=**/.env.*.local$",
    },
  })
end)
vim.keymap.set("n", "<leader>ft", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fs", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fc", builtin.commands, {})
-- find all references
vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})
-- goto definition
vim.keymap.set("n", "gd", builtin.lsp_definitions, {})
-- goto type defintion
vim.keymap.set("n", "gt", builtin.lsp_type_definitions, {})
