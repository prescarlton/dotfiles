# load env vars
source ~/.config/fish/env.fish

# start off with setting up tmux 
if status is-interactive
and not set -q TMUX
  exec tmux 
end

# add nvm to path so we can actually use the thing
set -x NVM_DIR ~/.nvm
nvm use lts --silent

# setup stupid fucking ruby - hate ruby so much
set -gx PATH "$HOME/.rbenv/shims:" $PATH

# add rust to the path :)
set -gx PATH "$HOME/.cargo/bin" $PATH

# add python bin to the path
set -gx PATH "/Users/presto/Library/Python/3.11/bin" $PATH

# add usr/local/bin (for oh my posh)
set -gx PATH "/home/presto/.local/bin" $PATH

# add go to path
set -gx PATH "/usr/local/go/bin" $PATH

set -gx GOPATH "/home/presto/go"
set -gx PATH $GOPATH/bin $PATH

# setup oh-my-posh
oh-my-posh --init --shell fish --config ~/.config/oh-my-posh/prompt.omp.json | source

# pnpm
set -gx PNPM_HOME "/Users/presto/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end


zoxide init fish --cmd cd | source
