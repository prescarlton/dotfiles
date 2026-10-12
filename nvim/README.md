# nvim

Neovim config built on lazy.nvim, native `vim.lsp`, mason, blink.cmp, snacks.nvim and nvim-treesitter (`main` branch).

## Setting up a new machine

Assumes macOS with Homebrew. Steps are in order.

### 1. Install system dependencies

```sh
xcode-select --install          # C compiler (treesitter parsers) + git
brew install neovim             # needs >= 0.12
brew install tree-sitter-cli    # nvim-treesitter `main` compiles parsers with this
brew install ripgrep fd         # file/grep pickers
brew install stylua             # lua formatter (conform)
brew install fish               # vim.opt.shell = "fish"
```

**Node.js** (via nvm) is required. mason installs most language servers with npm (vtsls, eslint, tailwind, css, cssmodules, prisma, pyright), and copilot.vim runs on node.

```fish
# fish: install nvm.fish, then
nvm install lts
```

**A Nerd Font** is needed for icons, set as your terminal font or as a symbol fallback. Examples: JetBrainsMono Nerd Font or Hack Nerd Font.

```sh
brew install --cask font-jetbrains-mono-nerd-font
```

### 2. Link the config

```sh
git clone <this repo> ~/dotfiles
ln -s ~/dotfiles/nvim ~/.config/nvim
```

### 3. Install plugins, parsers and language servers

```sh
nvim --headless "+Lazy! restore" +qa   # plugins at the versions pinned in lazy-lock.json
nvim                                   # first launch: treesitter parsers + mason servers install in the background
```

Wait for the installs to finish (check with `:Mason`), then restart nvim. These servers install automatically, from `ensure_installed` in `lua/plugins/lsp.lua`:

biome, cssls, cssmodules_ls, eslint, lua_ls, prismals, pyright, tailwindcss, terraformls, vtsls

### 4. Formatters

conform (`lua/plugins/formatting.lua`) runs the project's own `node_modules/.bin/prettier` or `biome` when they exist. To get prettier formatting in files outside a JS project, also install it globally:

```sh
npm i -g prettier
```

### 5. Language toolchains (optional)

Install only what you use:

| Language | Install | Notes |
|---|---|---|
| Rust | `brew install rustup && rustup-init && rustup component add rust-analyzer` | rustaceanvim runs rust-analyzer itself (it is deliberately not managed by mason-lspconfig). |
| Go | `brew install go`, then `:MasonInstall gopls` in nvim | gopls is enabled automatically once installed. |
| C# | Install the .NET SDK (`brew install --cask dotnet-sdk`) | csharp.nvim installs omnisharp through mason when you first open a `.cs` file. |
| Terraform | — | terraformls comes from mason. |

### 6. Sign in to Copilot

```
:Copilot setup
```

## Checking it worked

```
:checkhealth
```

Errors under `vim.lsp`, `nvim-treesitter`, `blink.cmp`, `mason` or `lazy` mean something is missing. The other warnings are safe to ignore: snacks' optional tools (lazygit, imagemagick, latex, mermaid) and the language providers (python, perl, ruby, node).

Open a `.tsx` file inside a project, then run `:checkhealth vim.lsp`. It should list vtsls, eslint or biome, and tailwindcss as attached.

## Layout

```
init.lua              entry point; loads lua/config/*
lua/config/           options, keymaps, autocmds, lazy.nvim bootstrap
lua/plugins/          one lazy.nvim spec file per area (lsp, completion, snacks, ui, ...)
lsp/                  per-server overrides, merged on top of nvim-lspconfig's defaults
lazy-lock.json        pinned plugin versions (commit this after :Lazy update)
stylua.toml           lua formatting (2 spaces)
```
