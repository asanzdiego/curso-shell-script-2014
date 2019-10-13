#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

ROLES_FILE=./roles.csv

ROLES=$(cut -d : -f 2 $ROLES_FILE | sed 's/,/\n/g' | sort | uniq)

for ROL in $ROLES; do

    echo "$ROL"
    NAMES=$(grep -E "$ROL $ROLES_FILE" | cut -d : -f 1)

    echo " -> $NAMES"
done
