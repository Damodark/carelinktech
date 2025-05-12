# Use official Python image
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install --no-install-recommends -y gcc libgomp1 && \
    rm -rf /var/lib/apt/lists/* && \
    adduser --disabled-password --gecos '' carelink

# Set working directory
WORKDIR /app

# Upgrade pip
RUN pip install --upgrade pip

# Copy requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create non-root user after installing packages
RUN chown -R carelink:carelink /app
USER carelink
ENV HOME=/home/carelink
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Copy source code
COPY --chown=carelink:carelink . .

# Expose port
EXPOSE 8000

# Start Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "carelinktech.wsgi:application"]