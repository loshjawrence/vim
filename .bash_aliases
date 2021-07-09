alias nvim="/usr/local/bin/nvim"
alias s="source ~/.bashrc"
alias e="explorer.exe ."

alias b="cmake -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_CLANG_TIDY=clang-tidy; make -j8 -Cbuild"
alias bd="cmake -Bbuild_debug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_CLANG_TIDY=clang-tidy; make -j8 -Cbuild_debug"

alias bdc="cmake --build ./build_debug --target generate-coverage"

alias bt="cmake --build ./build --target tidy"
alias bdt="cmake --build ./build_debug --target tidy"

alias bsa="make -Cbuild cppcheck"
alias bdsa="make -Cbuild_debug cppcheck"

alias bh="cmake --build ./build --target help"
alias bdh="cmake --build ./build_debug --target help"

alias bat="batcat"
alias dockerdance="docker-compose down -v; docker-compose pull; docker-compose up -d; npm run docker;"

# # Cpp builds via docker
# alias b="sh ~/scripts/build.sh r"
# alias bd="sh ~/scripts/build.sh d"
