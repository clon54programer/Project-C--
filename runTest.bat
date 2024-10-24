@echo Ejecutando los test de zig
zig build Test --summary all
@echo Ejecutando lost test de cpp
zig build TestCpp --summary all