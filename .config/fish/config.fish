set fish_greeting "" 

set -g theme_display_user yes
set -g theme_hide_hostname no
set -g default_user ___

# set -gx TERM xterm-256color

set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
set -g FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_DEFAULT_COMMAND "fd --type d --search-path $HOME/dev --exclude .git --exclude venv --exclude '**/target' --exclude node_modules"

set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/ripgreprc

alias .. "cd .."
alias python python3
alias pip pip3
alias g git
alias c clear
alias q exit
alias cat bat
alias sed gsed

# eza
alias ll "eza -l -g --icons"
alias lla "ll -a"

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

### NVM
set -gx NVM_DIR ~/.nvm

function __check_rvm --on-variable PWD --description 'Do nvm stuff'
  status --is-command-substitution; and return

  if test -f .nvmrc; and test -r .nvmrc;
    nvm use
  else
  end
end

### VENV
# tmux auto activate venv
if test -n "$VIRTUAL_ENV"
  source $VIRTUAL_ENV/bin/activate.fish
end
# venv prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
# agnoster theme venv colors
set -q color_virtual_env_bg; or set -g color_virtual_env_bg magenta
set -q color_virtual_env_str; or set -g color_virtual_env_str black

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
