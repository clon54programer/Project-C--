
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
> zig build --summary all

## Comando para probar el codigo.
> zig run .\main.zig -lmath -L.\zig-out\lib
__nota__: Debe ser ejecutado, luego de usar comando de construcion.

## Comando para ejecutar los test
> zig build Test --summary all
> zig build TestCpp --sumarry all

__nota__: Si en la salida de consola, no aparece nada es que los test aun funcionado como deberian.

# Cosas que aprendi

- la opcion __b.addTest__, solo funciona con arhivos __.zig__. Para crear un test usado un archivo de C+, debo usar
- la opcion __b.AddExecutable__.


## Como crear un ejecutable con el zig build System

Para crear un ejecutable con el zig build system, primero debemos crear una constante,
que debe ser inicializanda con el metodo __b.addExecuable__. Luego de est, debe
inicializar una estructura de la siguiente manera:


```zig
const exe = b.addExecutable(.{
        .name = "main",
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("main.zig"),
    });
```

El atributo __name__ hace referencia al nombre del ejecutable.
El atributo __target__ hace referencia al sistema o arquitetura que queremos compilar el programa.
El atributo __optimize__ se refiere a las optimizaciones que desea que tenga el ejecutable, por default
esta en debug para permitir la depuracion del ejecutable con un depurador.
El atributo __rout_source_file__ se refiere al archivo que contiene la funcion __pub fn main() !void__ de su
programa, ya que nuestro programa puede estar distribuido en diferentes archivos. Y, __b.path__ ayuda al
build system a identificar la ruta del archivo.



