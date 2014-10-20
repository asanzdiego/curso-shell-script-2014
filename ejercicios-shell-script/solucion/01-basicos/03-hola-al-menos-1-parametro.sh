#! /bin/bash

# script que saca un "Hola " + parámetros + "!" por pantalla
# y que verifica que hayamos introducido al menos un parámetro

echo "número de parámetros = $#"

# si número de parámetros menor o igual que 0
if [ $# -le 0 ]; then
  echo "Hay que introducir al menos un parámetro."
  exit 1
fi

echo "Hola $@!"
