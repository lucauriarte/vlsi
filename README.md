# Principios de Diseño VLSI — Ejercicios de Programación

Repositorio con los proyectos de Quartus II correspondientes a las guías de ejercicios de la materia **Principios de Diseño VLSI**.

## Herramientas

- **Quartus II 13.0sp1** (Web Edition)
- FPGAs de laboratorio compatibles con Quartus II 13.0sp1

## Estructura del repositorio

```
vlsi/
├── guia1/
│   ├── ejercicio1/
│   │   ├── ejercicio1.qpf   # Archivo de proyecto Quartus
│   │   ├── ejercicio1.qsf   # Configuración y asignaciones (pines, device, etc.)
│   │   └── *.vhd / *.v      # Archivos HDL fuente
│   └── ejercicio2/
│       └── ...
├── guia2/
│   └── ...
├── guia4/
│   └── ...
└── README.md
```

## Archivos incluidos en el repositorio

Solo se versiona lo necesario para reproducir el proyecto en otra PC:

| Archivo | Descripción |
|---------|-------------|
| `.qpf` | Quartus Project File — define el proyecto |
| `.qsf` | Quartus Settings File — asignaciones de pines, device, timing, etc. |
| `.vhd` / `.v` | Código fuente VHDL o Verilog |
| `.bdf` | Block Diagram File (si se usa entrada esquemática) |
| `.sdc` | Synopsys Design Constraints (restricciones de timing, si aplica) |

Los archivos generados por compilación (`db/`, `incremental_db/`, `output_files/`, etc.) están excluidos mediante `.gitignore` ya que se regeneran al compilar.

## Cómo clonar y abrir un proyecto

1. Clonar el repositorio:
   ```bash
   git clone <url-del-repositorio>
   ```

2. Abrir Quartus II 13.0sp1.

3. Ir a **File → Open Project** y seleccionar el archivo `.qpf` del ejercicio deseado.

4. Compilar con **Processing → Start Compilation** (o `Ctrl+L`).

> La primera compilación regenera automáticamente las carpetas `db/` y `output_files/`.

## Guías

| Guía | Contenido |
|------|-----------|
| [guia4/](guia4/) | Ejercicios de la Guía 4 |
