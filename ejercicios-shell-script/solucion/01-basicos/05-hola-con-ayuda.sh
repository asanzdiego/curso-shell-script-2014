#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

# script que saca un "Hola " + parámetros + "!" por pantalla
# separando cada parámetro con una coma (,)
# que verifica que hayamos introducido al menos un parámetro
# y que muestra una ayuda en caso de error

# función de ayuda
function ayuda() {

cat << DESCRPCION_AYUDA
SYNOPSIS
	$0 NOMBRE_1 [NOMBRE_2] ... [NOMBRE_N]

DESCRIPCION
   Muestra "Hola NOMBRE_1, NOMBRE_2, ... NOMBRE_N!" por pantalla.

CÓDIGOS DE RETORNO
	1 Si el número de parámetros es menor que 1

DESCRPCION_AYUDA

}

# si número de parámetros <= 0
if test $# -le 0 ; then
  echo "Hay que introducir al menos un parámetro."
  ayuda
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
echo "$MENSAJE"

exit 0
