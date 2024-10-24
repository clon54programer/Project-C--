
# Project C++

Este es un proyecto en donde uso zig build system para construir una libreria de C++. 
En esta prueba, uso aspectos del build system, como:

- Busqueda de headers
- linkeo de librerias
    - estandar
    - propias
- creacion de test con zig y C++.

# Comandos

## Comando para construir la biblioteca
> zig build

## Comando para probar el codigo.
> zig run .\main.zig -lmath -L.\zig-out\lib
__nota__: Debe ser ejecutado, luego de usar comando de construcion.

## Comando para ejecutar los test
> zig build Test

__nota__: Si en la salida de consola, no aparece nada es que los test aun funcionado como deberian.

# Cosas que aprendi

la opcion __b.addTest__, solo funciona con arhivos __.zig__. Para crear un test usado un archivo de C+, debo usar
la opcion __b.AddExecutable__.
