FROM python:3.8-slim-buster

VOLUME /class-scheduler
WORKDIR /class-scheduler

# Install dependencies
RUN apt-get update \
    && apt-get update -y \
    && apt-get install --no-install-recommends -y gringo \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip3 --no-cache-dir install -r requirements.txt
