# Base image: Python 3.11 slim (equilibrio entre tamaño y compatibilidad)
FROM python:3.11-slim

# Metadata OpenContainers
LABEL org.opencontainers.image.title="GitLab MR MCP Server"
LABEL org.opencontainers.image.description="MCP Server for GitLab Merge Request reviews, comments, approvals, and CI/CD integration"
LABEL org.opencontainers.image.source="https://github.com/amirsina-mandegari/gitlab-mr-mcp"
LABEL org.opencontainers.image.licenses="MIT"

# Variables de entorno para Python
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Instalar gitlab-mr-mcp desde PyPI
# Usamos --no-cache-dir para reducir tamaño de imagen
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir gitlab-mr-mcp

# Crear directorio de trabajo
WORKDIR /app

# Entry point: ejecutar el servidor MCP
ENTRYPOINT ["gitlab-mcp"]

