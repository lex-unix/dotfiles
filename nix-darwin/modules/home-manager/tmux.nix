{ pkgs, userConfig, ... }:
let
  themes = {
    dark = {
      accent = "#E78A4D";
      muted = "#928375";
      border = "#504946";
    };
    light = {
      accent = "#0769DA";
      muted = "#57606A";
      border = "#CFD7DE";
    };
  };
  palette = themes.${userConfig.theme};
in
{
  enable = true;
  baseIndex = 1;
  keyMode = "vi";
  prefix = "C-t";
  terminal = "xterm-256color";
  shell = "${pkgs.fish}/bin/fish";
  newSession = false;
  sensibleOnTop = false;
  disableConfirmationPrompt = true;

  extraConfig = ''
    set-option -sa terminal-features ',xterm-kitty:RGB'
    set-option -g automatic-rename on
    set-option -g automatic-rename-format '#{b:pane_current_path}'

    bind -T copy-mode-vi v send-keys -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'

    # Reload settings
    bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
    # Open current directory
    bind o run-shell "open #{pane_current_path}"
    bind -r e kill-pane -a

    # vim-like pane switching
    bind -r k select-pane -U
    bind -r j select-pane -D
    bind -r h select-pane -L
    bind -r l select-pane -R

    # Moving window
    bind-key -n C-S-Left swap-window -t -1 \; previous-window
    bind-key -n C-S-Right swap-window -t +1 \; next-window

    # Resizing pane
    bind -r C-k resize-pane -U 5
    bind -r C-j resize-pane -D 5
    bind -r C-h resize-pane -L 5
    bind -r C-l resize-pane -R 5

    set -g status-interval 1
    set -g status on
    set -sg escape-time 0
    set -g status-justify centre
    set -g focus-events on
    set -g allow-passthrough on

    set -g status-left-length "100"
    set -g status-right-length "100"
    set-option -g status-style bg=default

    set -g message-style "fg=${palette.muted},bg=default"
    set -g message-command-style "fg=${palette.muted},bg=default"

    set -g pane-border-style "fg=${palette.border}"
    set -g pane-active-border-style "fg=${palette.muted}"

    set -g status-left "#[fg=${palette.accent},bg=default] #S"
    set -g status-right "#[fg=${palette.accent},bg=default] %l:%M %p"

    set -g pane-active-border-style bg=default,fg=${palette.border}
    set -g pane-border-style fg=${palette.border}

    setw -g window-status-separator "    "
    setw -g window-status-style "NONE,fg=${palette.muted},bg=default"
    setw -g window-status-format '#I:#{b:pane_current_command}'
    setw -g window-status-current-format '#[fg=${palette.accent}]#I:#{b:pane_current_command}*'
  '';
}
