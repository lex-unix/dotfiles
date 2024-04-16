function load_env
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
end
