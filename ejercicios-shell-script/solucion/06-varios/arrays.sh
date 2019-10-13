#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

declare -a ARRAY;

ARRAY=("cero" "uno" [3]="tres")
ARRAY[2]="dos"

LENGTH=${#ARRAY[*]}

for (( i=0; i<LENGTH; i++ )); do
    echo $i=${ARRAY[i]}
done
