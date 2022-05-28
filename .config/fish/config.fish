set fish_greeting "" 

set -g theme_display_user yes
set -g theme_hide_hostname no
set -g default_user ___

set -gx TERM xterm-256color

alias up "cd .."
alias python python3
alias pip pip3
alias g git

if type -q exa
  alias ll "exa -l -g --icons"
  alias lla "ll -a"
end

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH /opt/homebrew/bin $PATH

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
