function tmux_sessionizer
  set -l selected
  if test (count $argv) -eq 1
    set selected $argv[1]
  else
    set selected (
      fd \
          --type d \
          --max-depth 1 \
          --search-path $HOME/dev \
          --search-path $HOME/dev/labs \
      | fzf \
          --layout=reverse \
          --height=65% \
          --border=sharp \
          --tabstop=1 \
          --keep-right \
          --info=hidden \
          --exit-0 \
          --cycle \
          --preview-window=down,70%,sharp \
          --preview='
            if test -f {}/README.md
                bat --decorations=never --color=always {}/README.md
            else
                eza --tree --level 1 --icons --color always {}
            end'

    )
  end


  if test -z $selected
    return
  end

  set selected_name (basename "$selected" | tr . _)
  set tmux_running (pgrep tmux)

  # tmux is not running
  if test -z $TMUX; and test -z $tmux_running
    tmux new-session -s $selected_name -c $selected
    return
  end

  # tmux is running but not active
  if test -z $TMUX; and test -n $tmux_running
    if not tmux has-session -t $selected_name 2> /dev/null 
      tmux new-session -s $selected_name -c $selected
    else
        tmux attach-session -t $selected_name
    end
  end

  # tmux running and active
  if not tmux has-session -t $selected_name 2> /dev/null 
    tmux new-session -ds $selected_name -c $selected
  end


  tmux switch-client -t $selected_name
end
