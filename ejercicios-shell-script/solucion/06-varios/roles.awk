# esto se ejecutará solo una vez al principio
BEGIN {
    FS = ",|:"
}

# esto se ejecutará para cada una de las líneas del fichero
{
    nombre=$1

    for (N=2; N<=NF; N++) {

        rol=$N

        roles[rol]=""roles[rol]" "nombre
    }
}

# esto se ejecutará solo una vez al final
END {
    for ( rol in roles) {
        print rol
        print " ->" roles[rol]
    }
}
