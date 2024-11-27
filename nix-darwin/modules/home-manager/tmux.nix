{ pkgs, ... }:
{
  enable = true;
  baseIndex = 1;
  keyMode = "vi";
  prefix = "C-t";
  terminal = "screen-256color";
  shell = "${pkgs.fish}/bin/fish";
  newSession = true;
  sensibleOnTop = false;
  disableConfirmationPrompt = true;

  extraConfig = ''
    set-option -g default-command "${pkgs.reattach-to-user-namespace}/bin/reattach-to-user-namespace -l ${pkgs.fish}/bin/fish"

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

    set -g status-left-length "100"
    set -g status-right-length "100"
    set-option -g status-style bg=default

    set -g message-style "fg=#C1C0D4,bg=default"
    set -g message-command-style "fg=#C1C0D4,bg=default"

    set -g pane-border-style "fg=#191724"
    set -g pane-active-border-style "fg=#C1C0D4"

    set -g status-left "#[fg=#757581,bg=default] #S"
    set -g status-right "#[fg=#757581,bg=default] %l:%M %p"

    set -g pane-active-border-style bg=default,fg=#2a2a2a
    set -g pane-border-style fg=#2a2a2a

    setw -g window-status-separator "    "
    setw -g window-status-style "NONE,fg=#757581,bg=default"
    setw -g window-status-format '#I:#{b:pane_current_command}'
    setw -g window-status-current-format '#[fg=#ACA1CF]#I:#{b:pane_current_command}*'
  '';
}
