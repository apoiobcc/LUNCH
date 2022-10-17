FROM python:3.8-slim-buster

VOLUME /class-scheduler

# Install dependencies
WORKDIR /class-scheduler
COPY requirements.txt requirements.txt
RUN pip3 --no-cache-dir install -r requirements.txt
