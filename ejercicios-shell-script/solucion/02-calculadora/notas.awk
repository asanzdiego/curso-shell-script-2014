# esto se ejecutará solo una vez al principio
BEGIN {

	print "+---------------------------+-----+------+"
	print "| NOMBRE      EX1  EX2  EX3 | MED | APTO |"
	print "+---------------------------+-----+------+"
}

# esto se ejecutará para cada una de las líneas del fichero
{
	suma2+=$2
	suma3+=$3
	suma4+=$4
	mediaFila=($2+$3+$4)/3

	apto="NO"
	if ( mediaFila >= 5 ) {
		apto="SI"
		aptos++
	}
	
	print "| "$0" | "mediaFila" |  "apto"  |"
}

# esto se ejecutará solo una vez al final
END {
	media2=suma2/3
	media3=suma3/3
	media4=suma4/3
	media=(media2+media3+media4)/3
	print "+---------------------------+-----+------+"
	print "| MEDIAS      "media2"  "media3"  "media4" | "media" |   "aptos"  |"
	print "+---------------------------+-----+------+"
}
