# syntax=docker/dockerfile:1
FROM python:3.12-slim

# Eviter l'interactivité et accélérer pip
ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Etape de deps d'abord pour profiter du cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Code
COPY app.py .
COPY data ./data
# Port exposé (doc/indicatif)
EXPOSE 5000

# Démarrage via gunicorn (prod-ready)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
