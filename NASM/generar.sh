if [ $# -eq 1 ]
then    
    echo "Compilando y Enlazando"
    nasm -f elf64 -o $1.o $1.asm;  ld $1.o -o $1
    if [ $? -eq 0 ]
    then
        echo "Ejecutado"
        ./$1
    else
        echo "Error al Compilar y Enlazar"
    fi
else
    echo "-------------------------"
    echo "Error!"
    echo "Debes indicar solo 1 argumento"
    echo "El argumento debe ser el archivo a compilar sin extensión .asm"
    echo "Ejemplo: ./generar.sh filename"
    echo "Asegurarse que exista el archivo filename"
    echo "-------------------------"
fi

# sudo ./generar.sh hello
# sudo ../generar.sh hello