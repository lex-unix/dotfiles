function fish_user_key_bindings
  for mode in default insert
    # peco
    # bind --mode $mode \cr peco_select_history # Bind for peco select history to Ctrl+R
    # bind --mode $mode \cf peco_change_directory # Bind for peco change directory to Ctrl+F

    bind --mode $mode \cf tmux_sessionizer
  end

  fish_vi_key_bindings

  # vim-like
  bind \cl forward-char

  # prevent iterm2 from closing when typing Ctrl-D (EOF)
  bind \cd delete-char

  fzf_configure_bindings --directory=\co
end
