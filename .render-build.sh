#!/bin/bash
set -e

# Build Docker image
docker build -t techdestination .

# Apply database migrations
docker run --rm techdestination python manage.py migrate

# Collect static files (if needed)
docker run --rm techdestination python manage.py collectstatic --noinput