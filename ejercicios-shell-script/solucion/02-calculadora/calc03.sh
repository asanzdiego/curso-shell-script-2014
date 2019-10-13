#! /bin/bash

set -o errexit  # the script ends if a command fails
set -o pipefail # the script ends if a command fails in a pipe
set -o nounset  # the script ends if it uses an undeclared variable

# script que devuelve el valor de la expresión introducida

# función de ayuda
function ayuda() {
cat << DESCRIPCION_AYUDA
SYNOPIS
    $0 EXPRESIÓN_NUMÉRICA
DESCRIPCIÓN
    Muestra por pantalla el valor de EXPRESIÓN_NUMÉRICA.
CODIGOS DE RETORNO
    0 Si no hay ningún error.
    1 Si el número de parámetros es distinto de 1.
    2 Si hay un error de formato en la expresión introducida.
    3 Si hay un error de entra y salida.
    4 Si hay un error al ejecutar la expresión introducida.
DESCRIPCION_AYUDA
}

# función de error
#    $1 línea de error
#    $2 mensaje de error
#    $3 código de retorno 
function error() {
    echo "$0: línea $1: Error $3: $2"
    exit "$3"
}

# si primer parámetro == '-h' o == '--help'
if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    ayuda
    exit 0
fi

# si número de parámetros distinto 1
if [ $# -ne 1 ] ; then
    error $LINENO "Hay que introducir 1 y solamente 1 parámetro." 1
fi

# si el parámetro no concuerda con la expresión regular
if [ "$(echo "$1" | grep -E "^[\*\/0-9\(\)\+\-]+$")" == "" ]; then
    error $LINENO "Error de formato en la expresión introducida." 2
fi

# guardamos la expresión ($1) en el fichero oculto .expresion.awk
# dentro de la HOME del usuario
if ! echo "{ print $1 }" > ~/.expresion.awk
then
    error $LINENO "Error de entrada y salida." 3
fi

# ejecutamos awk con el fichero oculto .expresion.awk
if ! echo "" | awk -f ~/.expresion.awk 2> ~/.log.awk
then
     error $LINENO "Error al ejecutar la expresión introducida." 4
fi
