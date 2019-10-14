#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

# script que añade, busca y opera con movimientos bancarios.

# variables globales
BANCO_SCRIPT=./banco

# función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPIS
    $0 [OPCIONES]

DESCRIPCIÓN
    Añade y busca y opera con movimientos bancarios.

OPCIONES
    -h --help   Muesta esta ayuda.

CODIGOS DE RETORNO
     0 Si no hay ningún error.
DESCRIPCION_AYUDA
}

# función menu
function menu() {
cat << DESCRIPCION_MENU

+-----------------------------------------------------------------+
| MENU DEL BANCO                                                  |
+-----------------------------------------------------------------+
| a - Añadir un movimiento bancario.                              |
| b - Buscar un movimiento bancario.                              |
| l - Listar todos los movimientos bancarios ordenados por fecha. |
| t - Calcular el saldo total de la cuenta.                       |
| s - Salir del programa.                                         |
+-----------------------------------------------------------------+

DESCRIPCION_MENU
}

# función de error
#    $1 línea de error
#    $2 mensaje de error
function error() {
    echo "$0: línea $1: $2"
}

# función para añadir un movimiento bancario
function add() {
    echo "AÑADIR UN MOVIMIENTO BANCARIO"
    read -r -p "Introduce el fecha: " FECHA
    read -r -p "Introduce el concepto: " CONCEPTO
    read -r -p "Introduce la cantidad: " CANTIDAD
    $BANCO_SCRIPT --add "$FECHA" "$CONCEPTO" "$CANTIDAD"
    elegir_menu
}

# función para búscar un movimiento bancario
function search() {
    echo "BUSCAR MOVIMIENTO BANCARIO"
    read -r -p "Introduce un patrón de búsqueda: " PATRON
    $BANCO_SCRIPT --search "$PATRON"
    elegir_menu
}

# función para listar movimientos bancarios ordenados por mes y día
function list() {
    echo "LISTAR ORDENADO POR FECHA"
    $BANCO_SCRIPT --list
    elegir_menu
}

# función para mostrar el saldo total de la cuenta
function total() {
    echo "SALDO TOTAL DE LA CUENTA"
    $BANCO_SCRIPT --total
    elegir_menu
}

# función para salir del programa
function salir() {
    exit 0
}

# función opción invalida
function opcion_invalida() {
    echo "Opción '$1' inválida."
    elegir_menu
}

# función elegir_menu
function elegir_menu() {

    menu
    read -r -p "Elige una opción: " OPCION
    clear

    case "$OPCION" in
        a) add ;;
        b) search ;;
        l) list ;;
        t) total ;;
        s) salir ;;
        *) opcion_invalida "$OPCION";;
    esac
}

parametros() {
    # si primer parámetro == '-h' o == '--help'
    if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
        ayuda
        exit 0
    fi
}

if [ $# -gt 0 ]; then
    parametros "$1"
fi

clear

elegir_menu
