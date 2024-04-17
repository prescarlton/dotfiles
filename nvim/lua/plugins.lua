-- general packer setup/plugin installation
require("packer").startup(function(use)
  use("wbthomason/packer.nvim")

  -- syntax highlighting
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- colorschemes
  use("rafamadriz/neon")
  use({ "catppuccin/nvim", as = "catppuccin" })
  use("rmehri01/onenord.nvim")
  use("navarasu/onedark.nvim")
  use("folke/tokyonight.nvim")
  use("projekt0n/github-nvim-theme")

  use("neovim/nvim-lspconfig")
  -- cmp plugins
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-cmdline")
  use("hrsh7th/cmp-vsnip")
  use("onsails/lspkind-nvim")
  -- auto brackets / closing
  use("windwp/nvim-ts-autotag")
  use("windwp/nvim-autopairs")

  use("L3MON4D3/LuaSnip")
  use("glepnir/lspsaga.nvim")

  use("jose-elias-alvarez/null-ls.nvim")
  use("MunifTanjim/prettier.nvim")

  use("kyazdani42/nvim-web-devicons")
  use("norcalli/nvim-colorizer.lua")
  use("akinsho/nvim-bufferline.lua")

  use("dinhhuy258/git.nvim")
  use("lewis6991/gitsigns.nvim")

  -- telescope plugins (fuzzy finder)
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-file-browser.nvim")

  -- mason is used to better manage lsp plugins
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  -- rooter sets your working dir to the project dir automatically
  use("airblade/vim-rooter")

  -- sets up nvim to actually support nvim development
  use("folke/neodev.nvim")

  -- dope comment plugin for keymaps and better comment support.
  -- allegedly is cross-language and "super robust"
  -- use({
  --   "numToStr/Comment.nvim",
  --   config = function()
  --     require("Comment").setup()
  --   end,
  -- })
  use({
    "terrortylor/nvim-comment",
  })
  -- lets comments work in files that have multiple different languages (i.e. tsx)
  use("JoosepAlviste/nvim-ts-context-commentstring")
  -- lua LINNNNEEEE (not totally sold yet, this fr fr some vscode simp type stuff)
  use({
    "nvim-lualine/lualine.nvim",
    -- requires = { "nvim-tree/nvim-web-devicons", opt = true },
  })

  -- does some neat stuff with cursors
  use("yamatsum/nvim-cursorline")

  -- neat lil plugin for splitting and managing term sessions
  use({
    "rebelot/terminal.nvim",
    config = function()
      require("terminal").setup()
    end,
  })

  -- SPOTIFY. IN NVIM.
  use({
    "kadoBOT/nvim-spotify",
    requires = "nvim-telescope/telescope.nvim",
    require("nvim-spotify").setup({
      run = "make",
    }),
  })

  -- nvim-tree
  use("nvim-tree/nvim-tree.lua")
  use("nvim-tree/nvim-web-devicons")

  -- dashboard
  use("goolord/alpha-nvim")

  use("MunifTanjim/nui.nvim")
  -- noice (cute command popups)
  use("folke/noice.nvim")

  -- rust setup
  use("simrat39/rust-tools.nvim")

  -- comment out in case of AI uprising
  use({
    "Exafunction/codeium.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
  })

  -- (potentially) signatures
  use("ray-x/lsp_signature.nvim")

  -- cool lil dropmenus in topbar
  use("Bekaboo/dropbar.nvim")
  use("folke/trouble.nvim")
  use({
    "nvim-neorg/neorg",
    rocks = { "lua-utils.nvim", "nvim-nio", "nui.nvim", "plenary.nvim", "pathlib.nvim" },
    -- tag = "*", -- Pin Neorg to the latest stable release
    version = "v7.0.0",
    config = function()
      require("neorg").setup()
    end,
  })
end)

vim.cmd([[colorscheme github_dark]])

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
require("codeium").setup({})

-- menubar (dropbar) config
require("dropbar").setup({})
vim.ui.select = require("dropbar.utils.menu").select
