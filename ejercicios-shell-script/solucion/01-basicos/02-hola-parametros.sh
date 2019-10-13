#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

# script que saca un "Hola " + parámetros + "!" por pantalla

echo "Hola $*!"
