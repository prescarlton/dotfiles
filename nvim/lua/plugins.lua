local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- general lazy setup/plugin installation
require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "tsx",
          "typescript",
          "javascript",
          "toml",
          "fish",
          "php",
          "json",
          "yaml",
          "swift",
          "css",
          "html",
          "lua",
          "scss",
          "graphql",
        },
        autotag = { enable = true },
      })
      -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      -- parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
    end,
  },

  -- colorschemes
  "rafamadriz/neon",
  "rmehri01/onenord.nvim",
  "navarasu/onedark.nvim",
  "folke/tokyonight.nvim",
  "projekt0n/github-nvim-theme",
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nuvic/flexoki-nvim", name = "flexoki" },

  "neovim/nvim-lspconfig",
  -- cmp plugins
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-vsnip",
  "onsails/lspkind-nvim",
  -- auto brackets / closing
  "windwp/nvim-ts-autotag",
  "windwp/nvim-autopairs",

  -- "L3MON4D3/LuaSnip",
  "glepnir/lspsaga.nvim",

  -- "jose-elias-alvarez/null-ls.nvim",
  "nvimtools/none-ls.nvim",
  "MunifTanjim/prettier.nvim",

  "norcalli/nvim-colorizer.lua",
  "akinsho/nvim-bufferline.lua",

  "dinhhuy258/git.nvim",
  "lewis6991/gitsigns.nvim",

  -- telescope plugins (fuzzy finder)
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "nvim-telescope/telescope-file-browser.nvim",

  -- mason is used to better manage lsp plugins
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- rooter sets your working dir to the project dir automatically
  "airblade/vim-rooter",

  -- sets up nvim to actually support nvim development
  "folke/neodev.nvim",

  -- dope comment plugin for keymaps and better comment support.
  -- allegedly is cross-language and "super robust"
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  -- lua LINNNNEEEE (not totally sold yet, this fr fr some vscode simp type stuff)
  "nvim-lualine/lualine.nvim",

  -- does some neat stuff with cursors
  "yamatsum/nvim-cursorline",

  -- neat lil plugin for splitting and managing term sessions
  {
    "rebelot/terminal.nvim",
    config = function()
      require("terminal").setup()
    end,
  },

  -- SPOTIFY. IN NVIM.
  {
    "kadoBOT/nvim-spotify",
    dependencies = "nvim-telescope/telescope.nvim",
    build = "make",
    config = function()
      require("nvim-spotify").setup({})
    end,
  },
  -- nvim-tree
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",

  -- dashboard
  "goolord/alpha-nvim",

  "MunifTanjim/nui.nvim",
  -- noice (cute command popups)
  "folke/noice.nvim",
  -- "rcarriga/nvim-notify",
  -- rust setup
  "simrat39/rust-tools.nvim",

  -- comment out in case of AI uprising
  -- {
  --   "Exafunction/codeium.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  -- },
  "github/copilot.vim",
  -- (potentially) signatures
  "ray-x/lsp_signature.nvim",

  -- cool lil dropmenus in topbar
  "Bekaboo/dropbar.nvim",
  "folke/trouble.nvim",
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
  },
  {
    -- perhaps cmp for sass variables
    "pontusk/cmp-sass-variables",
  },
  -- light / dark mode based on system
  "cormacrelf/dark-notify",
  -- formatting
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  {
    "yetone/avante.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.pick",
    },
  },
  -- oml we're actually writing in c# these days (9/27/25), we're making a video game
  {
    "iabdelkareem/csharp.nvim",
    dependencies = {
    "williamboman/mason.nvim", -- Required, automatically installs omnisharp
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
  },
  config = function ()
      require("mason").setup() -- Mason setup must run before csharp, only if you want to use omnisharp
      require("csharp").setup()
  end
  }
})

-- COLORSCHEME

require("flexoki").setup({
  dim_inactive_windows = false,
  extend_background_behind_borders = false,
  styles = {
    bold = true,
    italic = true,
    transparency = true,
  }
})
vim.cmd.colorscheme("flexoki")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- autotags/autopair config
local autotag = require("nvim-ts-autotag")
autotag.setup({
  enable_close_on_slash = false,
})
local autopairs = require("nvim-autopairs")
autopairs.setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})

-- rq lil setup for rooter. basically giving special handling
-- for turbo repos (majority of my projects at time of writing)
vim.cmd([[let g:rooter_cd_cmd = 'lcd']])
vim.cmd([[ let g:rooter_patterns = ['turbo.json','.git'] ]])

require("nvim-cursorline").setup({
  cursorline = {
    enable = true,
    timeout = 1000,
    number = false,
  },
  cursorword = {
    enable = true,
    min_length = 3,
    hl = { underline = true },
  },
})
-- terminal config
require("terminal").setup({})
-- neodev setup
require("neodev").setup({})

require("rust-tools").setup()
-- require("codeium").setup({})

-- menubar (dropbar) config
require("dropbar").setup({})
vim.ui.select = require("dropbar.utils.menu").select

-- dark notify setup
local dn = require("dark_notify")
-- Configure
-- dn.run({
--   schemes = {
--     -- you can use a different colorscheme for each
--     dark = "github_dark",
--     light = "github_light",
--   },
-- })
-- dn.update()
