# Actividad de Sandboxing - Puesta en Producción Segura

## 📋 Descripción

Repositorio para la actividad de Sandboxing de la Unidad 1 del módulo **Puesta en Producción Segura**. 

Contiene:
- 📝 Reflexión sobre seguridad en lenguajes de programación
- 🐳 Implementación de sandbox con Docker para la aplicación `notas`
- 📚 Documentación completa del proceso con instrucciones paso a paso
- 🖼️ Placeholders para capturas de pantalla de las pruebas

## 📁 Estructura del Proyecto

```
PPSUnidad1-ActividadSandboxingIzan/
├── docs/
│   ├── reflexion-lenguajes.md        # Reflexión sobre seguridad en lenguajes
│   ├── documentacion-sandboxing.md   # Guía completa de uso del sandbox
│   └── ...                           # Otras docs generadas
├── src/                              # Código fuente de notas
├── scripts/                          # Scripts auxiliares
├── tests/                            # Tests de la aplicación
├── imagenes/                         # Capturas de pantalla (añadir manualmente)
├── Dockerfile                        # Configuración del sandbox
├── requirements.txt                  # Dependencias Python
├── Makefile                          # Comandos útiles
└── README.md                         # Este archivo
```

## 🚀 Uso Rápido

### Construir el Sandbox

```bash
# En el directorio raíz del proyecto
docker build -t notas-sandbox .
```

### Ejecutar la Aplicación

```bash
# Ejecutar de forma interactiva
docker run --rm -it notas-sandbox
```

### Ejecutar con Límites de Recursos

```bash
# Con límites de memoria y CPU
docker run --rm -it \
  --memory="512m" \
  --cpus="0.5" \
  notas-sandbox
```

## 📚 Documentación

- **[📝 Reflexión sobre Lenguajes](docs/reflexion-lenguajes.md)**: Análisis completo de seguridad en diferentes lenguajes de programación (Python, TypeScript, SQL, Rust, C/C++)
- **[🐳 Documentación Sandboxing](docs/documentacion-sandboxing.md)**: Guía detallada del proceso de sandboxing con instrucciones, comandos y placeholders para capturas

## 🔒 Características de Seguridad

El sandbox implementado incluye:

- ✅ **Contenedor Docker aislado** - Sin acceso al sistema host
- ✅ **Usuario sin privilegios** - Ejecución como `sandboxuser`
- ✅ **Límites de recursos configurables** - Control de CPU y memoria
- ✅ **Sin acceso a red del host** por defecto
- ✅ **Imágenes oficiales** - Python 3.11 slim de Docker Hub
- ✅ **Entorno reproducible** - Funciona igual en cualquier sistema

## ⚙️ Comandos Útiles

### Ver imágenes Docker
```bash
docker images
```

### Acceder al shell del contenedor
```bash
docker run --rm -it notas-sandbox /bin/bash
```

### Verificar usuario no privilegiado
```bash
docker run --rm notas-sandbox whoami
# Output esperado: sandboxuser
```

### Eliminar imagen
```bash
docker rmi notas-sandbox
```

### Limpiar recursos Docker
```bash
docker system prune -a
```

## 📋 Tareas Pendientes

### Para completar la actividad:

1. ✅ Crear repositorio
2. ✅ Escribir reflexión sobre lenguajes
3. ✅ Crear Dockerfile
4. ✅ Documentar proceso de sandboxing
5. ⚠️ **Ejecutar Docker localmente y tomar capturas de pantalla** (TU PARTE)
6. ⚠️ **Añadir capturas a `/imagenes` y actualizar los Markdown** (TU PARTE)
7. ⚠️ **Comprimir repositorio para entrega** (TU PARTE)

### Capturas necesarias (ver `docs/documentacion-sandboxing.md`):

- 📷 CAPTURA 1: Construcción del contenedor
- 📷 CAPTURA 2: Ejecución de notas
- 📷 CAPTURA 3: Verificación usuario no root
- 📷 CAPTURA 4: Ejecución con límites
- 📷 CAPTURA 5: Inspección de contenedores
- 📷 CAPTURA 6: Prueba de aislamiento de archivos
- 📷 CAPTURA 7: Intento de escalar privilegios
- 📷 CAPTURA 8: Aislamiento de red

## 👤 Autor

**Izan**  
Ciclo Formativo de Grado Superior en Ciberseguridad  
IES Valle del Jerte - Plasencia

## 📅 Fecha

Diciembre 2025

## 🏫 Asignatura

**Puesta en Producción Segura - Unidad 1**  
**Profesor**: José Miguel Medina

---

🔥 **Nota**: Los archivos de documentación están completamente listos. Solo necesitas ejecutar Docker localmente, tomar las capturas de pantalla indicadas y añadirlas donde se indica `[CAPTURA X]` en el archivo `docs/documentacion-sandboxing.md`
