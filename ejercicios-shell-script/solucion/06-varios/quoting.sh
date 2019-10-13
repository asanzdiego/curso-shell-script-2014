#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

test () {

    echo "dollar 1"
    echo $1

    echo "dollar *"
    echo $*

    echo "dollar @"
    echo $@

    echo "dollar 1 con doble comilla"
    echo "$1"

    echo "dollar * con doble comilla"
    echo "$*"

    echo "dollar @ con doble comilla"
    echo "$@"

    echo ">>>>>>>>>>>>>>>>>>>>>>>>>for dollar *"
    for i in $*; do echo "$i"; done

    echo ">>>>>>>>>>>>>>>>>>>>>>>>>for dollar @"
    for i in $@; do echo "$i"; done

    echo ">>>>>>>>>>>>>>>>>>>>>>>>>for dollar * con doble comilla"
    for i in "$*"; do echo "$i"; done

    echo ">>>>>>>>>>>>>>>>>>>>>>>>>for dollar @ con doble comilla"
    for i in "$@"; do echo "$i"; done
}

echo "asterisco"

test *

echo "==========================="
echo "asterisco con doble comilla"

test "*"