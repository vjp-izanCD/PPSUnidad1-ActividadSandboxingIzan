# Documentación: Sandboxing del Proyecto Lavadero

## Introducción

Este documento describe el proceso de sandboxing del proyecto **Lavadero** - un simulador de túnel de lavado de coches desarrollado en Python. Este proyecto complementa el proyecto "notas" ya implementado, demostrando la versatilidad del sandbox Docker para ejecutar diferentes aplicaciones de forma aislada.

## Descripción del Proyecto Lavadero

El proyecto Lavadero es una aplicación Python que simula el funcionamiento de un túnel de lavado automatizado de vehículos. Incluye:

- **Máquina de estados**: Gestiona las diferentes fases del lavado
- **Opciones configurables**: Prelavado a mano, secado a mano, encerado
- **Validación de reglas de negocio**: Control de opciones incompatibles
- **Cálculo de ingresos**: Sistema de facturación basado en servicios seleccionados
- **Tests automatizados**: Cobertura con pytest y unittest

### Estructura del Proyecto

```
src/
├── __init__.py
├── lavadero.py       # Clase principal del simulador
└── main_app.py       # Aplicación principal con ejemplos

tests/
├── test_lavadero_pytest.py    # Tests con pytest
└── test_lavadero_unittest.py  # Tests con unittest
```

## Ejecución en Sandbox Docker

### Comando 1: Ejecutar la Aplicación Principal

```bash
docker run --rm lavadero-sandbox python src/main_app.py
```

**➡️ [CAPTURA 9]: Ejecución de la aplicación lavadero**

*Descripción de lo que debe mostrar*:
- Comando ejecutado
- Simulaciones de diferentes combinaciones de lavado
- Cálculo de ingresos para cada opción
- Progreso por las diferentes fases del túnel

---

### Comando 2: Ejecutar Tests con Pytest

```bash
docker run --rm lavadero-sandbox pytest tests/test_lavadero_pytest.py -v
```

**➡️ [CAPTURA 10]: Tests del lavadero con pytest**

*Descripción*:
- Ejecución de pytest con salida verbose (-v)
- Lista de tests ejecutados
- Resultado PASSED para cada test
- Resumen final con estadísticas

---

### Comando 3: Ejecutar Tests con Unittest

```bash
docker run --rm lavadero-sandbox python -m unittest tests/test_lavadero_unittest.py -v
```

**➡️ [CAPTURA 11]: Tests del lavadero con unittest**

*Descripción*:
- Tests ejecutados con el framework unittest
- Verificación de todas las reglas de negocio
- Validación de cálculos de ingresos
- OK en todos los casos de prueba

---

### Comando 4: Ejecución con Límites de Recursos

```bash
docker run --rm --memory="256m" --cpus="0.5" lavadero-sandbox python src/main_app.py
```

**➡️ [CAPTURA 12]: Lavadero con límites de recursos**

*Descripción*:
- Ejecución con restricciones de memoria (256MB) y CPU (50%)
- Aplicación funcionando correctamente con recursos limitados
- Demostración del control de recursos del sandbox

---

## Casos de Prueba Implementados

### Test 1: Validación de Reglas de Negocio
- **Regla**: No se puede encerar sin secado a mano
- **Resultado esperado**: ValueError al intentar violar la regla

### Test 2: Cálculo de Ingresos
- Sin extras: 5.00€ (precio base)
- Prelavado a mano: +1.50€
- Secado a mano: +1.20€ 
- Encerado: +1.00€
- **Combinación completa**: 8.70€

### Test 3: Progreso de Fases
Verificación de que el lavadero avanza correctamente por las fases:
- Fase 0 (Inactivo) → 1 (Cobrando) → 2 (Prelavado*) → 3 (Agua) → 4 (Jabón) → 5 (Rodillos) → 6/7 (Secado) → 8 (Encerado*) → 0

*Opcional según configuración

### Test 4: Estado Ocupado
- **Regla**: No se puede iniciar nuevo lavado si hay uno en curso
- **Resultado esperado**: RuntimeError al intentar iniciar mientras está ocupado

## Comparación: Proyecto Notas vs Proyecto Lavadero

| Aspecto | Proyecto Notas | Proyecto Lavadero |
|---------|----------------|-------------------|
| **Tipo** | Gestión de datos | Simulación de procesos |
| **Complejidad** | Básica | Máquina de estados |
| **Tests** | CRUD operations | Reglas de negocio complejas |
| **Objetivo** | Almacenamiento | Lógica de negocio |
| **Archivos** | 1 módulo principal | 2 módulos + tests |

## Ventajas de Tener Ambos Proyectos

✅ **Diversidad de casos de uso**: Demuestra que el sandbox funciona con diferentes tipos de aplicaciones

✅ **Más cobertura de pruebas**: 2 conjuntos de tests independientes

✅ **Demostración de versatilidad**: Diferentes niveles de complejidad

✅ **Evidencia de competencia**: Implementación de múltiples proyectos Python

## Configuración del PYTHONPATH

El Dockerfile está configurado para soportar ambos proyectos:

```dockerfile
ENV PYTHONPATH=/app/src/notas:/app/src/lavadero:$PYTHONPATH
```

Esto permite que:
- `from notas import ...` funcione para el proyecto notas
- `from lavadero import ...` funcione para el proyecto lavadero

## Conclusiones

La implementación de dos proyectos diferentes (Notas y Lavadero) en el mismo entorno de sandboxing demuestra:

1. **Versatilidad del Docker**: Un único contenedor puede ejecutar múltiples aplicaciones
2. **Aislamiento efectivo**: Ambos proyectos funcionan independientemente sin conflictos
3. **Prácticas profesionales**: Estructura modular y organizada
4. **Testing completo**: Cobertura con diferentes frameworks (pytest y unittest)
5. **Documentación exhaustiva**: Proceso completo documentado para ambos proyectos

Esta actividad demuestra no sólo el dominio de Docker para sandboxing, sino también la capacidad de trabajar con proyectos Python de diferente complejidad y propósito.

---

**Autor**: Izan  
**Fecha**: Diciembre 2025  
**Asignatura**: Puesta en Producción Segura - Unidad 1  
**Centro**: IES Valle del Jerte - Plasencia
