#!/bin/bash
set -e

# Build Docker image
docker build -t karmatechdestination .

# Apply database migrations
docker run --rm karmatechdestination python manage.py migrate

# Collect static files (if needed)
docker run --rm karmatechdestination python manage.py collectstatic --noinput