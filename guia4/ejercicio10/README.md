# Ejercicio 10 — Análisis

## Comportamiento del circuito

El circuito es un **registro paralelo de 24 bits con disparo por flanco ascendente**, funcionalmente idéntico al del ejercicio 9, pero construido **instanciando dos veces la megafunción `lpm_ff`** (cada instancia configurada con `lpm_width = 12`) en lugar de un componente VHDL escrito a mano.

En cada flanco ascendente de `clk`, los 24 bits de `d` se transfieren a `q`. Internamente, `lpm_ff` se mapea directamente a 24 flip-flops D dedicados del FPGA.

## Estructura

```
ejercicio10
├── reg12a : lpm_ff (lpm_width=12)   →   d[11..0]  → q[11..0]
└── reg12b : lpm_ff (lpm_width=12)   →   d[23..12] → q[23..12]
```

Ambas instancias comparten el reloj. La diferencia clave con el ejercicio 9 es que aquí **no escribimos la arquitectura del registro**: `lpm_ff` ya está provisto por la librería `lpm` de Altera y el sintetizador la mapea al recurso óptimo del dispositivo.

## Características del componente `lpm_ff`

`lpm_ff` es la megafunción de **registro genérico parametrizable** de la librería *Library of Parameterized Modules* (LPM) de Altera. Sus rasgos principales:

### Parametrización (genéricos)

| Parámetro      | Significado                                            | Default |
|----------------|--------------------------------------------------------|---------|
| `lpm_width`    | Ancho del registro en bits (entero positivo)           | —       |
| `lpm_fftype`   | Tipo de flip-flop: `"DFF"`, `"TFF"`, `"JKFF"`, `"SRFF"` | `"DFF"` |
| `lpm_avalue`   | Valor cargado en activación asíncrona (`aset`)         | —       |
| `lpm_svalue`   | Valor cargado en activación síncrona (`sset`)          | —       |
| `lpm_pvalue`   | Valor inicial al encendido (power-up)                  | —       |

En este ejercicio sólo se usa `lpm_width => 12`, así que cada instancia es un registro D de 12 bits, sin clear, sin enable, sin load.

### Puertos relevantes

| Puerto    | Dirección | Función                                       |
|-----------|-----------|-----------------------------------------------|
| `data`    | in        | Datos a registrar (`lpm_width` bits)          |
| `clock`   | in        | Reloj de escritura (flanco ascendente)        |
| `q`       | out       | Salida registrada (`lpm_width` bits)          |
| `enable`  | in        | *Clock enable* (opcional)                     |
| `aclr`    | in        | Borrado asíncrono (opcional)                  |
| `aset`    | in        | Set asíncrono al valor `lpm_avalue` (opc.)    |
| `aload`   | in        | Carga asíncrona desde `data` (opcional)       |
| `sclr`    | in        | Borrado síncrono (opcional)                   |
| `sset`    | in        | Set síncrono al valor `lpm_svalue` (opcional) |
| `sload`   | in        | Carga síncrona desde `data` (opcional)        |

Los puertos opcionales que no se conectan en el `port map` quedan inactivos (con su valor por defecto: borrado/preset/carga deshabilitados, enable a `'1'`).

### Ventajas frente a escribir un proceso VHDL

1. **Portabilidad y optimización**: Quartus mapea `lpm_ff` directamente al recurso dedicado del FPGA elegido (en Cyclone II, los flip-flops de los LE). No depende de la inferencia que pueda hacer el sintetizador a partir de un `process`.
2. **Configuración por genéricos**: cambiar el ancho, agregar enable o clear asíncrono se hace modificando un parámetro, sin reescribir lógica.
3. **Comportamiento estandarizado**: el módulo está validado por Altera y se comporta igual en simulación funcional y post-fitter.

La contracara es que se acopla al ecosistema Altera/Intel: el código deja de ser portable a otras tecnologías sin reescribir los `lpm_*` por equivalentes propios o de otro proveedor.

## Comparación con el ejercicio 9

| Aspecto                       | Ejercicio 9 (`reg12` propio) | Ejercicio 10 (`lpm_ff`)           |
|-------------------------------|------------------------------|------------------------------------|
| Cómo se obtiene el registro   | Proceso VHDL inferido        | Megafunción LPM instanciada        |
| Líneas de código              | Más (define la arquitectura) | Menos (sólo `port map`)            |
| Portabilidad entre vendors    | Alta (VHDL puro)             | Baja (depende de librería `lpm`)   |
| Resultado tras síntesis       | Flip-flops D del FPGA        | Flip-flops D del FPGA (equivalente) |

Funcionalmente ambos diseños sintetizan al **mismo circuito** sobre el FPGA. La diferencia es de estilo de descripción.
