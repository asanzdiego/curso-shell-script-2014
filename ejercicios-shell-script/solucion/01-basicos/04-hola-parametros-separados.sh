#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

# script que saca un "Hola " + parámetros + "!" por pantalla
# separando cada parámetro con una coma (,)
# y que verifica que hayamos introducido al menos un parámetro

# si número de parámetros menor o igual que 0
if [ $# -le 0 ]; then
  echo "Hay que introducir al menos un parámetro."
  exit 1
fi

MENSAJE="Hola"
PRIMERO=1

# mientras haya parámetros
while [ -n "$1" ]; do

	if [ $PRIMERO -eq 1 ]; then

		MENSAJE="$MENSAJE $1"
		PRIMERO=0
	else
		MENSAJE="$MENSAJE, $1"
	fi

	# pasamos al siguiente parámetro
	shift
done

# mostramos la salida por pantalla
echo "$MENSAJE!"
