function tmux_sessionizer
  set -l selected
  if test (count $argv) -eq 1
    set selected $argv[1]
  else
    set selected (fd --type d --hidden --follow --max-depth 2 --exclude .git --exclude node_modules --search-path $HOME/dev --search-path $HOME/dotfiles  | fzf)
  end


  if test -z $selected
    return
  end

  set selected_name (basename "$selected" | tr . _)
  set tmux_running (pgrep tmux)

  if test -z $TMUX; and test -z $tmux_running
    tmux new-session -s $selected_name -c $selected
    return
  end

  if not tmux has-session -t $selected_name 2> /dev/null 
    tmux new-session -ds $selected_name -c $selected
    return
  end

  tmux switch-client -t $selected_name
end
