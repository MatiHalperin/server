#!/bin/bash

function StartServer()
{
    while :
    do
        git pull --quiet

        if [ -f "commands" ]
        then
            while read -r line || [[ -n $line ]]
            do
                eval "$line" > "result"
            done < "commands"

            rm -rf "commands"

<<<<<<< HEAD
            git add . &> /dev/null
=======
            git add . > /dev/null
>>>>>>> 87bf8172062825201811c73d1b3f3fd286a15891
            git commit --quiet -m "Executed"
            git push --quiet
        fi
    done
}

function SendCommand()
{
    echo "$1" > "commands"

    rm -rf "result"

<<<<<<< HEAD
    git add . &> /dev/null
=======
    git add . > /dev/null
>>>>>>> 87bf8172062825201811c73d1b3f3fd286a15891
    git commit --quiet -m "Pushed"
    git push --quiet

    while [ ! -f "result" ]
    do
        git pull --quiet
    done

    cat "result"
}