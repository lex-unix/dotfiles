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
end
