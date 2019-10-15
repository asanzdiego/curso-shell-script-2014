#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

# script que añade, busca y opera con movimientos bancarios.

# variables globales
BANCO_SCRIPT=./banco

# función de ayuda
function help() {
cat << DESCRIPCION_AYUDA
SYNOPIS
    $0 [OPCIÓN] [PARÁMETROS]

DESCRIPCIÓN
    Añade, busca, lista y opera con movimientos bancarios.

OPCIONES
    -h --help                           Muestra una ayuda.
    -a --add    FECHA CONCEPTO CANTIDAD Añade un movimiento bancario.
    -s --search PATRÓN                  Busca un movimiento bancario.
    -l --list                           Lista los movimientos bancarios ordenados por fecha.
    -t --total                          Calcula el saldo total de la cuenta.

CÓDIGOS DE RETORNO
    0 Si no hay ningún error.
    1 Si la opción introducida no es válida.
    2 Si un argumento númerico no es un número.
    3 Si el número de parámetros es erróneo.
    4 Si un argumento de tipo fecha no es una fecha.
    5 Si hay un error de entrada/salida en el fichero de datos.
    6 Si no introducen ningún parámetro.
DESCRIPCION_AYUDA
}

# función para añadir un movimiento bancario
function add() {
    echo "AÑADIR UN MOVIMIENTO BANCARIO"
    $BANCO_SCRIPT --add "$@"
    echo "-----------------------------"
}

# función para búscar un movimiento bancario
function search() {
    echo "BUSCAR MOVIMIENTO BANCARIO ($*)"
    $BANCO_SCRIPT --search "$@"
    echo "-----------------------------"
}

# función para listar movimientos bancarios ordenados por mes y día
function list() {
    echo "LISTAR ORDENADO POR FECHA"
    $BANCO_SCRIPT --list
    echo "-----------------------------"
}

# función para mostrar el saldo total de la cuenta
function total() {
    echo "SALDO TOTAL DE LA CUENTA"
    $BANCO_SCRIPT --total
    echo "-----------------------------"
}

# función opción invalida
function opcion_invalida() {
    echo "Opción '$1' inválida."
    exit 6
}

# si número de parámetros menor o igual que 0
if [ $# -le 0 ]; then
    echo "Hay que introducir al menos un parámetro."
    help
    exit 6
fi

case $1 in
    -h|--help)                  help;;
    -a|--add)    shift;     add "$@";;
    -s|--search) shift;  search "$@";;
    -l|--list)                  list;;
    -t|--total)                total;;
    *) exitWithError $LINENO "Opción '$1' inválida." 1
esac
