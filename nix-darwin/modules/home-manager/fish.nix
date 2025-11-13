{ userConfig, pkgs, ... }:
{
  enable = true;
  package = pkgs.fish;

  interactiveShellInit = ''
    set fish_greeting ""

    set -gx LEX_THEME ${userConfig.theme}

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
    cat = "bat";
    ll = "eza -l -g --icons";
    lla = "ll -a";
    nix-rebuild = "sudo darwin-rebuild switch --flake ~/dotfiles/nix-darwin";
    lgit = "lazygit";
    ".." = "cd ..";
    oc = "opencode";
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
    load_env = {
      body = ''
        if test -z "$argv" ; or not test -e $argv[1]
          echo "Usage: load_env <path to .env file>"
          return 1
        end

        for line in (string match -rv '^\s*($|#)' (string trim (cat $argv[1])))
          set -l key (string trim (string split --max 1 "=" -- $line)[1])
          set -l value (string trim (string split --max 1 "=" -- $line)[2])
          set -l value (string replace -ar "[\"']" "" -- $value)

          if test -n "$key" -a -n "$value"
            set -gx $key $value
          end
        end
      '';
    };
    rayci = {
      body = ''
        git diff | pbcopy
        open raycast://ai-commands/git-commit-message
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
                      bat --decorations=never --color=always {}/README.md
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
          commandline --function repaint
          return
        end

        # tmux running and active
        if not tmux has-session -t $selected_name 2> /dev/null
          tmux new-session -ds $selected_name -c $selected
        end

        tmux switch-client -t $selected_name
        commandline --function repaint
      '';
    };
  };
}
