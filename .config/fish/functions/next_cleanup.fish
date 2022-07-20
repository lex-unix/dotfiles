function next_cleanup
  if test -e .gitignore
    rm .gitignore
  end

  if test -e README.md
    rm README.md;
  end

  if test -e .git -a -d .git
    rm -rf .git
  end

  if test -e pages -a -e styles
    if read_confirm
      mkdir -p src
      mv pages/ styles/ src/
    end
  end
  echo "Done!"
end

function read_confirm
  while true
    read -l -P 'Do you want to create src directory? [y/N] ' confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end
