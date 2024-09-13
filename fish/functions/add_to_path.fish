function add_to_path
  if set -q argv[1] ; and test -d "$argv[1]"
    set -l target_path (path resolve $argv[1])
    set -gx PATH $PATH $target_path
    echo "Added $target_path to \$PATH."
  else
    echo "Please provide a valid directory path as an argument."
    return 1
  end
end

