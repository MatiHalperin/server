#!/bin/bash

function StartServer()
{
    while :
    do
        git pull --quiet

        if [ -f "command" ]
        then
            COMMAND=$(cat "command")
            "$COMMAND" &> "result"

            rm -rf "command"

            git add . &> /dev/null
            git commit --quiet -m "Executed"
            git push --quiet
        fi
    done
}

function SendCommand()
{
    echo "$1" > "command"

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