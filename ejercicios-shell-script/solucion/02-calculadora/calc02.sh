#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

# script que realiza operaciones simples (suma resta multiplicacion división)
# entre dos números

# función de ayuda
function ayuda() {

cat << DESCRIPCION_AYUDA
SYNOPSIS
	$0 NUMERO_1 OPERACIÓN NUMERO_2

DESCRIPCIÓN
	Retorna el resultado de la OPERACIÓN
	entre NUMERO_1 y NUMERO_2

	OPERACIÓN puede tener estos valores:
		+ sum mas
		- res menos
		x mul por
		/ div entre

CÓDIGOS DE RETORNO
	1 Si el número de parámetros es distinto de 2.
	2 Si algún parámetro no es un número.
	3 Si la operación introducida es inválida.
DESCRIPCION_AYUDA

}

function comprobarQueNoEsNumero() {

	if [ -n "$1" ] \
		&& [ "$1" != "0" ] \
		&& [ "$(echo "$1" | awk '{ print $1*1 }')" != "$1" ]; then

		echo "El parámetro '$1' no es un número"
		ayuda
		exit 2
	fi
}

if [ $# -ne 3 ]; then
	echo "El número de parámetros debe de ser igual a 3"
	ayuda
	exit 1
fi

comprobarQueNoEsNumero "$1"
comprobarQueNoEsNumero "$3"

case $2 in
    +|sum|mas)   echo "$1" "$3" | awk '{ print $1 + $2 }' ;;
    -|res|menos) echo "$1" "$3" | awk '{ print $1 - $2 }' ;;
    x|mul|por)   echo "$1" "$3" | awk '{ print $1 * $2 }' ;;
    /|div|entre) echo "$1" "$3" | awk '{ print $1 / $2 }' ;;
    *) echo "La operación '$2' es inválida." ; ayuda ; exit 3 ;;
esac
