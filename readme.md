
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
que debe ser inicializanda con el metodo __b.addExecuable__. Luego de esto, debe
inicializar una estructura de la siguiente manera:


```zig
const exe = b.addExecutable(.{
        .name = "main",
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("main.zig"),
    });
```

- El atributo __name__ hace referencia al nombre del ejecutable.
- El atributo __target__ hace referencia al sistema o arquitetura que queremos compilar el programa.
- El atributo __optimize__ se refiere a las optimizaciones que desea que tenga el ejecutable, por default
esta en debug para permitir la depuracion del ejecutable con un depurador.
- El atributo __rout_source_file__ se refiere al archivo que contiene la funcion __pub fn main() !void__ de su
programa, ya que nuestro programa puede estar distribuido en diferentes archivos. Y, __b.path__ ayuda al
build system a identificar la ruta del archivo.

### Datos extras

#### ¿Como construir un ejecutable con codigo C++ o C?

El anterior forma funciona con codigo zig, si usa esta configuracion con codigo diferente,
mandara un error al momento de analizar el codigo fuente, por esa razon voy a mostrar la forma 
para construir un ejecutable con codigo C++ o C, que sigue la misma estructura, pero debemos realizar unas configuraciones extras.

```zig
 const test_sumCpp = b.addExecutable(.{
        .name = "SumCpp",
        .target = target,
        .optimize = optimize,
    });
```

Si, se pregunta porque no hacemos referencia al __rout_source_file__ es porque ese opcion es valida
solamente para codigo zig. Del resto de configuracion es la misma, pero con alguna opciones extras.

Debajo de la anterior configuracion se debe colocar lo siguiente.

```zig
<nombre de la constante>.addIncludePath(b.path("include"));
<nombre de la constante>.addCSourceFiles(.{ .files = &.{"test/TestSum.cpp"} });
<nombre de la constante>.linkLibCpp();
<nombre de la constante>.linkLibrary(lib);
```

- El metodo __addIncludePath__ especificamos al build system, la ubicacion de headers externos de 
la libreria estandar.
- El metodo __addCSourceFiles__ especificamos al build system, los archivos C++ para construir el ejecutable.
- El metodo __linkLibCpp__ especificamos al build system, que linke al ejecutable la libreria estandar de C++.
Si, usted usa codigo se debe usar la siguiente funcion __linkLibC__.
El metodo __linkLibrary__ especificamos al build system, que linkee una libreria externa.

#### Comandos extras

El metodo __linkSystemLibrary__ especificamos al build system, que linkee una libreria del sistema operativo
al cual queremos compilar.

El metodo __addLibraryPath__ especicamos al build system, la ubicacion de un libraria estatica o dinamica
precompilada con anteridad. Por favor, verifique que la abi de la libreria sea compatible con la de zig,
porque sino, mandara un error de linkeo.





