function compile_and_run_cpp --description "Compile and run C++ using brew g++"
  if not test -e ./src
    mkdir src;
    mv *.cpp ./src
  end

  if not test -e ./bin
    mkdir bin;
  end

  g++-12 -fopenmp src/main.cpp -o bin/main
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

