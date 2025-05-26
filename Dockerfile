# techdestination/Dockerfile

FROM python:3.12-slim

RUN apt-get update && \
    apt-get install --no-install-recommends -y gcc libgomp1 libpq-dev && \
    rm -rf /var/lib/apt/lists/* && \
    adduser --disabled-password --gecos '' carelink

WORKDIR /app

USER root
RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "karmatechdestination.wsgi:application"]