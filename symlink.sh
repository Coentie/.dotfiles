#!/usr/bin/sh

 for dir in ./usr/local/bin/*/
 do
    dirname=${dir%*/}      # remove the trailing "/"
    echo $dirname
    # dirname=$(echo "${dir##*/}")    # print everything after the final "/"   
    cd $(echo $dirname) && stow .
 done
