#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

# script interfaz del script 'citas'

# variables globales
CITAS_SCRIPT=./citas

# función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPIS
    $0 [OPCIONES]

DESCRIPCIÓN
    Añade y busca citas HORA_INICIAL, HORA_FINAL y NOMBRE_PACIENTE.

OPCIONES
    -h --help    Muesta esta ayuda.

CODIGOS DE RETORNO
    0 Si no hay ningún error.
DESCRIPCION_AYUDA
}

# función menu
function menu() {
cat << DESCRIPCION_MENU

+---------------------------------------------------------------------+
| MENU DE CITAS                                                       |
+---------------------------------------------------------------------+
| a. Añadir una cita con HORA_INICIAL, HORA_FINAL, y NOMBRE_PACIENTE. |
| s. Buscar los pacientes que contengan PATRÓN.                       |
| i. Buscar las citas que empiecen a HORA_INICIAL.                    |
| e. Buscar las citas que terminen a HORA_FINAL.                      |
| n. Listar todas las citas ordenadas por NOMBRE_PACIENTE.            |
| o. Listar todas las citas ordenadas por HORA_INICIAL.               |
| s. Salir del programa.                                              |
+---------------------------------------------------------------------+

DESCRIPCION_MENU
}

# función de error
#    $1 línea de error
#    $2 mensaje de error
function error() {

    echo "$0: línea $1: $2"
}

# función para añadir una cita
function add() {

    echo "AÑADIR UNA CITA NUEVA"
    read -r -p "Introduce la hora inicial (de 00 a 23): " HORA_INICIAL
    read -r -p "Introduce la hora final (de 00 a 23): " HORA_FINAL
    read -r -p "Introduce el nombre del paciente: " NOMBRE_PACIENTE
    $CITAS_SCRIPT --add "$HORA_INICIAL" "$HORA_FINAL" "$NOMBRE_PACIENTE"
}

# función de búsqueda
function search() {

    echo "BUSCAR POR HORA INICIAL, HORA FINAL o NOMBRE DEL PACIENTE"
    read -r -p "Introduce un patrón de búsqueda: " PATRON
    $CITAS_SCRIPT --search "$PATRON"
}

# función de búsqueda por hora inicial
function init() {

    echo "BUSCAR POR HORA INICIAL"
    read -r -p "Introduce la hora inicial (de 00 a 23): " HORA_INICIAL
    $CITAS_SCRIPT --init "$HORA_INICIAL"
}

# función de búsqueda por hora final
function end() {

    echo "BUSCAR POR HORA FINAL"
    read -r -p "Introduce la hora final (de 00 a 23): " HORA_FINAL
    $CITAS_SCRIPT --end "$HORA_FINAL"
}

# función de listado ordenados por nombres
function name() {

    echo "LISTADO ORDENADO POR NOMBRE DEL PACIENTE"
    $CITAS_SCRIPT --name
}

# función de listado ordenados por hora de inicial
function hour() {

    echo "LISTADO ORDENADO POR HORA INICIAL"
    $CITAS_SCRIPT --hour
}

# función para salir del programa
function salir() {

    exit 0
}

# función elegir_menu
function elegir_menu() {

    menu
    read -r -p "Elige una opción: " OPCION
    clear

    case $OPCION in
        a) add ;;
        s) search ;;
        i) init ;;
        e) end ;;
        n) name ;;
        o) hour ;;
        s) salir ;;
        *) error $LINENO "Opción $OPCION inválida." ;;
    esac

    elegir_menu
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
