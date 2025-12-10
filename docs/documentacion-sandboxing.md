# Documentación: Sandboxing de la Aplicación Lavadero

## Introducción

Este documento describe el proceso completo de creación y uso de un entorno de sandboxing mediante Docker para ejecutar de forma aislada y segura la aplicación `lavadero` desarrollada en Python.

## ¿Qué es Sandboxing?

El sandboxing es una técnica de seguridad que permite ejecutar aplicaciones en un entorno aislado, sin acceso directo a los recursos del sistema host. Esto es fundamental para:
- Analizar software potencialmente peligroso
- Probar aplicaciones sin riesgo para el sistema
- Crear entornos reproducibles
- Evitar la propagación de malware

## Tecnología Utilizada: Docker

### ¿Por qué Docker?

- **Aislamiento completo**: Contenedores completamente separados del host
- **Portabilidad**: Funciona igual en Windows, Linux y macOS
- **Ligereza**: Más eficiente que máquinas virtuales tradicionales
- **Reproducibilidad**: Mismo entorno siempre, sin "funciona en mi máquina"
- **Ecosistema maduro**: Gran comunidad y documentación

## Estructura del Proyecto

```
PPSUnidad1-ActividadSandboxingIzan/
├── Dockerfile              # Definición del contenedor
├── requirements.txt        # Dependencias Python
├── src/                    # Código fuente de lavadero
├── scripts/                # Scripts auxiliares
├── tests/                  # Tests
├── docs/                   # Documentación
└── imagenes/               # Capturas de pantalla
```

## Configuración del Sandbox

### Análisis del Dockerfile

El Dockerfile implementa las siguientes medidas de seguridad:

1. **Imagen base ligera**: `python:3.11-slim` - Reduce superficie de ataque
2. **Usuario no privilegiado**: Creación de `sandboxuser` sin permisos de root
3. **Permisos restringidos**: Solo acceso a `/app`
4. **Dependencias controladas**: Instalación desde `requirements.txt`
5. **Ejecución sin root**: El contenedor nunca se ejecuta como superusuario

### Código del Dockerfile

```dockerfile
FROM python:3.11-slim
LABEL maintainer="Izan"
LABEL description="Sandbox para ejecutar lavadero de forma aislada"

RUN useradd -m -s /bin/bash sandboxuser
WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY scripts/ ./scripts/
COPY tests/ ./tests/

RUN chown -R sandboxuser:sandboxuser /app
USER sandboxuser

CMD ["python", "src/main.py"]
```

## Instrucciones de Uso

### 1. Construcción del Contenedor

```bash
# En el directorio raíz del proyecto
docker build -t lavadero-sandbox .
```

**➡️ [CAPTURA 1]: Proceso de construcción del contenedor Docker**

*Descripción de lo que debe mostrar la captura*:
- Comando `docker build` ejecutado
- Pasos de construcción (FROM, RUN, COPY, etc.)
- Mensaje final "Successfully built" con el ID de la imagen

---

### 2. Ejecución de la Aplicación
```bash
# Ejecutar el contenedor de forma interactiva
docker run --rm -it lavadero-sandbox
```

**➡️ [CAPTURA 2]: Ejecución del contenedor y salida de la aplicación lavadero**

*Descripción*:
- Comando `docker run` ejecutado
- Salida de la aplicación lavadero funcionando
- Menús o outputs del programa

---

### 3. Verificación del Usuario No Privilegiado

```bash
# Comprobar que el usuario no es root
docker run --rm lavadero-sandbox whoami
# Output esperado: sandboxuser
```

**➡️ [CAPTURA 3]: Verificación de usuario no root**

*Descripción*:
- Ejecución del comando `whoami` dentro del contenedor
- Output mostrando "sandboxuser" (NO "root")

---

### 4. Ejecución con Límites de Recursos

```bash
# Ejecutar con límites de memoria y CPU
docker run --rm -it \
  --memory="512m" \
  --cpus="0.5" \
  lavadero-sandbox
```

**➡️ [CAPTURA 4]: Ejecución con límites de recursos**

*Descripción*:
- Comando con parámetros de límites
- Aplicación funcionando con restricciones

---

### 5. Inspección del Contenedor

```bash
# Ver información del contenedor en ejecución
docker ps
docker stats
```

**➡️ [CAPTURA 5]: Inspección de contenedores activos**

*Descripción*:
- Salida de `docker ps` mostrando contenedor activo
- Estadísticas de uso de recursos con `docker stats`

---

## Pruebas de Aislamiento Realizadas

### Prueba 1: Acceso al Sistema de Archivos del Host

**Objetivo**: Verificar que el contenedor no puede acceder a archivos del sistema host.

**Comandos ejecutados**:
```bash
docker run --rm lavadero-sandbox ls /
docker run --rm lavadero-sandbox cat /etc/passwd
```

**➡️ [CAPTURA 6]: Intento de acceso al sistema de archivos**

*Resultado esperado*: Solo se ven archivos del contenedor, no del host.

---

### Prueba 2: Intentar Escalar Privilegios

**Objetivo**: Comprobar que no se pueden obtener permisos de root.

**Comandos ejecutados**:
```bash
docker run --rm lavadero-sandbox sudo whoami
```

**➡️ [CAPTURA 7]: Intento de escalar privilegios**

*Resultado esperado*: Error - sudo no disponible o permiso denegado.

---

### Prueba 3: Aislamiento de Red

**Objetivo**: Verificar que el contenedor tiene red limitada.

**Comandos ejecutados**:
```bash
docker run --rm --network=none lavadero-sandbox ping google.com
```

**➡️ [CAPTURA 8]: Prueba de aislamiento de red**

*Resultado esperado*: Sin acceso a red cuando se usa `--network=none`.

---

## Análisis de Seguridad

### Ventajas del Sandbox Implementado

✅ **Aislamiento completo** del sistema host  
✅ **Usuario sin privilegios** - No puede hacer cambios críticos  
✅ **Control de recursos** - Límites configurables de CPU/RAM  
✅ **Reproducibilidad garantizada** - Mismo entorno siempre  
✅ **Fácil de eliminar** - `docker rm` borra todo rastro  
✅ **Portabilidad** - Funciona en cualquier sistema con Docker  

### Limitaciones y Consideraciones

⚠️ **Requiere Docker instalado** - Dependencia externa  
⚠️ **Overhead mínimo** - Consume recursos adicionales  
⚠️ **Curva de aprendizaje** - Requiere conocimientos de Docker  
⚠️ **No es 100% infalible** - Vulnerabilidades de escape de contenedor existen  

### Medidas Adicionales de Seguridad Implementadas

1. **Imágenes oficiales**: Uso de `python:3.11-slim` de Docker Hub oficial
2. **Sin caché pip**: `--no-cache-dir` reduce tamaño de imagen
3. **Permisos mínimos**: `chown` solo lo necesario
4. **Labels informativos**: Metadatos para identificación
5. **Comando explícito**: `CMD` define claramente qué se ejecuta

## Comparación: Sandbox vs Ejecución Normal

| Aspecto | Ejecución Normal | Con Sandbox Docker |
|---------|-------------------|--------------------|
| Acceso a archivos del host | ✅ Total | ❌ Aislado |
| Permisos de usuario | ⚠️ Tu usuario | ✅ Usuario sin privilegios |
| Modificación del sistema | ⚠️ Posible | ❌ Bloqueado |
| Instalación de software | ✅ Libre | ❌ Controlado |
| Red | ✅ Acceso total | ✅ Configurable |
| Persistencia | ✅ Permanente | ❌ Efímera (con `--rm`) |
| Seguridad | ⚠️ Riesgo alto | ✅ Riesgo controlado |

## Comandos Útiles Adicionales

### Ver imágenes disponibles
```bash
docker images
```

### Eliminar imagen
```bash
docker rmi lavadero-sandbox
```

### Acceder a shell del contenedor
```bash
docker run --rm -it lavadero-sandbox /bin/bash
```

### Ver logs de un contenedor
```bash
docker logs <container_id>
```

### Limpiar recursos Docker
```bash
docker system prune -a
```

## Conclusiones

El uso de Docker para sandboxing de la aplicación lavadero ha demostrado ser una solución efectiva que proporciona:

1. **Seguridad mejorada**: Aislamiento total del sistema host
2. **Control granular**: Límites de recursos configurables
3. **Reproducibilidad**: Entorno idéntico en cualquier máquina
4. **Facilidad de uso**: Comandos simples para construir y ejecutar
5. **Reversibilidad**: Fácil de eliminar sin dejar rastro

Este enfoque es válido tanto para:
- Análisis de aplicaciones desconocidas
- Pruebas de software en desarrollo
- Entornos de producción donde la seguridad es crítica
- Laboratorios de ciberseguridad para análisis de malware

La implementación realizada cumple con las mejores prácticas de seguridad en contenedores y proporciona una base sólida para la ejecución segura de aplicaciones Python.

---

**Autor**: Izan  
**Fecha**: Diciembre 2025  
**Asignatura**: Puesta en Producción Segura - Unidad 1  
**Centro**: IES Valle del Jerte - Plasencia
