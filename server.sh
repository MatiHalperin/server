#!/bin/bash

function StartServer()
{
    while :
    do
        git pull --quiet

        if [ -f ".server/command" ]
        then
            COMMAND=$(cat ".server/command")
            "$COMMAND" &> ".server/result"

            rm -rf ".server/command"

            git add ".server/result" &> /dev/null
            git commit --quiet -m "Executed"
            git push --quiet
        fi
    done
}

function SendCommand()
{
    echo "$1" > ".server/command"

    rm -rf ".server/result"

    git add ".server/command" &> /dev/null
    git commit --quiet -m "Pushed"
    git push --quiet

    while [ ! -f ".server/result" ]
    do
        git pull --quiet
    done

    cat ".server/result"
}

function CreateServer()
{
    git init
    git remote add origin "$1"
    git pull origin master
}