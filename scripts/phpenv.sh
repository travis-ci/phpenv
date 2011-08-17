#!/bin/bash
#/ Usage: phpenv <command> [<args>]
#/
#/ Some useful commands:
#/     rehash         Generate new wrapper scripts for executables
#/     set-default    Set the current user's default PHP version
#/     set-local      Set the PHP version for the current working 
#/                    directory and all subdirectories
#/     versions       List all available PHP versions
#/     version        Get the current PHP version
#/
#/ Type "phpenv help <command>" to get help for a command.
#/

export PHPENV_ROOT=$HOME/.phpenv
export PHPENV_SCRIPTS_DIR=$PHPENV_ROOT/scripts
export PATH="$PHPENV_ROOT/bin:$PATH"

if [ ! -d "$PHPENV_ROOT/bin" ] || [ ! -d "$PHPENV_ROOT/versions" ]; then
    mkdir -p "$PHPENV_ROOT/"{versions,bin}
fi

function phpenv {
    if [ -z $1 ]; then
        echo "phpenv: Argument \"command\" is missing." >&2
        return 1
    fi

    if [ "$1" = "--version" ] || [ "$1" = "-v" ]; then
        echo $(cat "$PHPENV_ROOT/VERSION")
        return 0
    fi

    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        "$PHPENV_SCRIPTS_DIR/help.sh" "phpenv"
        return 1
    fi

    if [ ! -f "$PHPENV_SCRIPTS_DIR/$1.sh" ]; then
        echo "phpenv: Command \"$1\" not found."
        return 1
    fi

    command=$1
    shift

    "$PHPENV_SCRIPTS_DIR/$command.sh" $@

    if [ "$command" = "rehash" ]; then
        hash -r
    fi

    return $?
}
export -f phpenv

phpenv rehash

