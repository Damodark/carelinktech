#!/bin/bash
set -e

# Build Docker image
docker build -t carelinktech .

# Apply database migrations
docker run --rm carelinktech python manage.py migrate

# Collect static files (if needed)
docker run --rm carelinktech python manage.py collectstatic --noinput