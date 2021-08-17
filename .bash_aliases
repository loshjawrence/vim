alias nvim="/usr/local/bin/nvim"
alias s="source ~/.bashrc"
alias e="explorer.exe ."
alias ea="nvim ~/.bash_aliases"

# help
alias bh="cmake --build build --target help"
alias bdh="cmake --build build_debug --target help"

# build
alias b="cmake -Bbuild -DCMAKE_BUILD_TYPE=Release && make -j8 -Cbuild"
alias bd="cmake -Bbuild_debug -DCMAKE_BUILD_TYPE=Debug && make -j8 -Cbuild_debug"

# tests
alias bt="bd; cd build_debug; ctest --output-on-failure; cd -;"
alias btt="bd; ./build_debug/bin/tests"
# alias bt="cmake --build build_debug --target tests; cd build_debug; ctest --output-on-failure; cd -;"
# alias btt="cmake --build build --target tests; ./build_debug/bin/tests"

# format
alias bf="cmake --build build_debug --target clang-format-fix-all;"

# coverage
alias bc="cmake --build build_debug --target generate-coverage"

# clang-tidy
alias by="cmake --build build_debug --target clang-tidy"

# static analysis
alias bs="cmake --build build_debug --target cppcheck"

alias bat="batcat"
alias dockerdance="docker-compose down -v; docker-compose pull; docker-compose up -d; npm run docker;"

# # Cpp builds via docker
# alias b="sh ~/scripts/build.sh r"
# alias bd="sh ~/scripts/build.sh d"
