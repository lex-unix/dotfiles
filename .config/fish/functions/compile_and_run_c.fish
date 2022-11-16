function compile_and_run_c --description 'Compile and run C using brew gcc'
  if not test -e ./src
    mkdir src;
    mv *.c ./src
  end

  if not test -e ./bin
    mkdir bin;
  end

  gcc-12 -fopenmp src/main.c -o bin/main
  bin/main
end


function read_confirm
  while true
    read -l -P 'Extra flags? ' confirm

    switch $confirm
      case Y y
        return 0
      case '' N n
        return 1
    end
  end
end


