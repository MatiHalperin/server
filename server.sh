#!/bin/bash

function CreateServer()
{
    git init
    git remote add origin "$1"
    git pull origin master
}

function StartServer()
{
    if [ ! -d ".server" ]
    then
        mkdir ".server"
    fi

    while :
    do
        git pull --quiet

        if [ -f ".server/command" ]
        then
            eval "$(cat ".server/command")" &> ".server/result"

            rm -rf ".server/command"

            git add ".server/result .server/command" &> /dev/null
            git commit --quiet -m "Executed"
            git push --quiet
        fi
    done
}

function SendCommand()
{
    if [ ! -d ".server" ]
    then
        mkdir ".server"
    fi

    echo "$1" > ".server/command"

    rm -rf ".server/result"

    git add ".server/command .server/result" &> /dev/null
    git commit --quiet -m "Pushed"
    git push --quiet

    while [ ! -f ".server/result" ]
    do
        git pull --quiet
    done

    cat ".server/result"
}