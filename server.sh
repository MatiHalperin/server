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

            git add . &> /dev/null
            git commit --quiet -m "Executed"
            git push --quiet
        fi
    done
}

function SendCommand()
{
    echo "$1" > "commands"

    rm -rf "result"

    git add . &> /dev/null
    git commit --quiet -m "Pushed"
    git push --quiet

    while [ ! -f "result" ]
    do
        git pull --quiet
    done

    cat "result"
}