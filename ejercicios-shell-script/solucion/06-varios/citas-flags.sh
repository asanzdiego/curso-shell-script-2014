#! /bin/bash

# script interfaz del script 'citas'

# variables globales
CITAS_SCRIPT=./citas

# función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPIS
	$0 [OPCIONES] [HORA_INICIAL] [HORA_FINAL] [NOMBRE_PACIENTE]

DESCRIPCIÓN
	Añade y busca citas de una consulta.

OPCIONES
	-h --help   Para mostrar un texto de ayuda.
	-a --add    Para añadir una cita con HORA_INICIAL, HORA_FINAL, y NOMBRE_PACIENTE.
	-s --search Para buscar los pacientes que contengan PATRÓN.
	-i --init   Para buscar las citas que empiecen a HORA_INICIAL.
	-e --end    Para buscar las citas que terminen a HORA_FINAL.
	-n --name   Para listar todas las citas ordenadas por NOMBRE_PACIENTE.
	-o --hour   Para listar todas las citas ordenadas por HORA_INICIAL.

CÓDIGOS DE RETORNO
	0 Si no hay ningún error.
	1 Si el número de parámetros es incorrecto.
	2 Si el formato de los parámetros es incorrecto.
	3 Si al añadir una cita se solapa con otra ya introducida.
	4 Si al añadir una cita ya existe NOMBRE_PACIENTE.
	5 Si se introduce una opción inválida.
	6 Si ocurre otro error no mencionado.
DESCRIPCION_AYUDA
}


# función de error
#	$1 línea de error
#	$2 mensaje de error
function error() {

	echo "$0: línea $1: $2"
}

# función para añadir una cita
function add() {

	echo "AÑADIR UNA CITA NUEVA"
	$CITAS_SCRIPT --add $@
	echo "----------------------------------------"
}

# función de búsqueda
function search() {

	echo "BUSCAR POR PATRÓN ($@)"
	$CITAS_SCRIPT --search $@
	echo "----------------------------------------"
}

# función de búsqueda por hora inicial
function init() {

	echo "BUSCAR POR HORA INICIAL"
	$CITAS_SCRIPT --init $@
	echo "----------------------------------------"
}

# función de búsqueda por hora final
function end() {

	echo "BUSCAR POR HORA FINAL"
	$CITAS_SCRIPT --end $@
	echo "----------------------------------------"
}

# función de listado ordenados por nombres
function name() {

	echo "LISTADO ORDENADO POR NOMBRE DEL PACIENTE"
	$CITAS_SCRIPT --name
	echo "----------------------------------------"
}

# función de listado ordenados por hora de inicial
function hour() {

	echo "LISTADO ORDENADO POR HORA INICIAL"
	$CITAS_SCRIPT --hour
	echo "----------------------------------------"
}

# función opción invalida
function opcion_invalida() {
    echo "Opción '$1' inválida."
    exit 5
}

while getopts "ha:s:lt" option ; do 
    case "$option" in 
        h) ayuda ;;
        a) add $OPTARG ;;
        s) search $OPTARG ;;
        i) init $OPTARG ;;
        e) end $OPTARG ;;
        n) name ;;
        o) hour ;;
        *) opcion_invalida $option ;;
    esac
done
