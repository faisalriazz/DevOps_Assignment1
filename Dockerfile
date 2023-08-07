FROM python:3.8-slim

MAINTAINER Faisal "faisalriaz@hotmail.com"

ADD . /fastapi

WORKDIR /fastapi
COPY . /fastapi
RUN pip install -r requirement.txt

ENTRYPOINT python3 run.py 