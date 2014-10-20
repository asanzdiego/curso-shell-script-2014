#! /bin/bash

# script que añade, busca y opera con movimientos bancarios.

# variables globales
BANCO_SCRIPT=./banco

# función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPIS
    $0  [OPCIÓN] [PARÁMETROS]

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
	1 SI la opción introducida no es válida.
	2 si un argumento númerico no es un número.
	3 Si el número de parámetros es erróneo.
	4 si un argumento de tipo fecha no es una fecha.
	5 Si hay un error de entrada/salida en $BANCO_FILE.
DESCRIPCION_AYUDA
}


# función para añadir un movimiento bancario
function add() {
    echo "AÑADIR UN MOVIMIENTO BANCARIO"
    $BANCO_SCRIPT --add $@
    echo "-----------------------------"
}

# función para búscar un movimiento bancario
function search() {
    echo "BUSCAR MOVIMIENTO BANCARIO ($1)"
    $BANCO_SCRIPT --search $1
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

while getopts "ha:s:lt" option ; do 
    case "$option" in 
        h) ayuda ;;
        a) add $OPTARG ;;
        s) search $OPTARG ;;
        l) list ;;
        t) total ;;
        *) opcion_invalida $option ;;
    esac
done
