set fish_greeting ""

set -g theme_display_user yes
set -g theme_hide_hostname no
set -g default_user ___

alias .. "cd .."
alias python python3
alias pip pip3
alias g git
alias c clear
alias q exit
alias cat bat

# eza
alias ll "eza -l -g --icons"
alias lla "ll -a"

# coreutils
alias sed gsed
alias du gdu
alias stat gstat

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH ~/.cargo/bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# Android Studio
set -gx ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set -gx PATH $ANDROID_SDK_ROOT/emulator $PATH
set -gx PATH $ANDROID_SDK_ROOT/platform-tools $PATH

# fzf
set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_DEFAULT_COMMAND "fd --type d --search-path $HOME/dev --exclude .git --exclude venv --exclude '**/target' --exclude node_modules"

# ripgrep
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc

# zoxide
zoxide init fish | source

# starship
starship init fish | source

source $HOME/.config/fish/local.fish
