# Dockerfile para Sandbox de Lavadero
# Imagen base ligera de Python
FROM python:3.11-slim

LABEL maintainer="Izan"
LABEL description="Sandbox para ejecutar la aplicación lavadero de forma aislada y segura"

# Crear usuario sin privilegios para ejecutar la aplicación
RUN useradd -m -s /bin/bash sandboxuser

# Establecer directorio de trabajo
WORKDIR /app

# Copiar requirements e instalar dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copiar código de la aplicación
COPY src/ ./src/
COPY scripts/ ./scripts/
COPY tests/ ./tests/

# Cambiar permisos al usuario no privilegiado
RUN chown -R sandboxuser:sandboxuser /app

# Cambiar al usuario no privilegiado
USER sandboxuser

# Exponer puerto si es necesario (ajustar según aplicación)
# EXPOSE 8000

# Comando por defecto para ejecutar la aplicación
CMD ["python", "src/main.py"]
