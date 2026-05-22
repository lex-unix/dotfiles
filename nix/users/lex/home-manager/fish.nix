{
  currentTheme,
  lib,
  pkgs,
  ...
}: {
  programs.fish = {
    enable = true;
    package = pkgs.fish;

    interactiveShellInit = ''
      set fish_greeting ""

      set -gx LEX_THEME ${currentTheme}

      # Go
      set -gx PATH $GOPATH/bin $PATH

      # fzf
      set -g FZF_PREVIEW_FILE_CMD "bat --style=numbers --color=always --line-range :500"
      set -g FZF_LEGACY_KEYBINDINGS 0

      source $HOME/.config/fish/local.fish
    '';

    shellAliases = {
      g = "git";
      c = "clear";
      q = "exit";
      j = "jj";
      cat = "bat";
      ll = "eza -l -g --icons";
      lla = "ll -a";
      ".." = "cd ..";
      oc = "opencode attach --dir . http://0.0.0.0:4096";
    };

    plugins = [
      {
        name = "fzf.fish";
        src = pkgs.fetchFromGitHub {
          owner = "patrickf1";
          repo = "fzf.fish";
          rev = "v10.3";
          sha256 = "1hqqppna8iwjnm8135qdjbd093583qd2kbq8pj507zpb1wn9ihjg";
        };
      }
    ];

    functions = {
      fish_user_key_bindings = {
        body = ''
          for mode in default insert
            bind --mode $mode \cf tmux_sessionizer
          end

          fish_vi_key_bindings
          fzf_configure_bindings --directory=\co
          # prevent iterm2 from closing when typing Ctrl-D (EOF)
          bind \cd delete-char
        '';
      };
      add_to_path = {
        body = ''
          if set -q argv[1] ; and test -d "$argv[1]"
            set -l target_path (path resolve $argv[1])
            set -gx PATH $PATH $target_path
            echo "Added $target_path to \$PATH."
          else
            echo "Please provide a valid directory path as an argument."
            return 1
          end
        '';
      };
      tmux_sessionizer = {
        body = ''
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
                        ${pkgs.mdcat}/bin/mdcat {}/README.md
                    else
                        eza --tree --level 1 --icons --color always {}
                    end'
            )

            if test $status -ne 0
              builtin commandline --function cancel-commandline repaint
              return
            end
          end

          if test -z $selected
            return
          end

          set -l selected_name (basename "$selected" | tr . _)

          if not tmux has-session -t $selected_name 2> /dev/null
            tmux new-session -ds $selected_name -c $selected
          end

          if test -z $TMUX
            tmux attach-session -t $selected_name
          else
            tmux switch-client -t $selected_name
          end

          commandline --function repaint
        '';
      };
    };
  };
}
