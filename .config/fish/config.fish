set fish_greeting "" 

set -g theme_display_user yes
set -g theme_hide_hostname no
set -g default_user ___

set -gx TERM xterm-256color

alias .. "cd .."
alias python python3
alias pip pip3
alias g git
alias c clear

# exa
alias ll "exa -l -g --icons"
alias lla "ll -a"

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH
set -gx PRETTIERD_DEFAULT_CONFIG ~/.prettierrc.js

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

# Android Studio
set -gx ANDROID_SDK_ROOT $HOME/Library/Android/sdk
set -gx PATH $ANDROID_SDK_ROOT/emulator $PATH
set -gx PATH $ANDROID_SDK_ROOT/platform-tools $PATH

### NVM
set -gx NVIM_DIR ~/.nvm

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
