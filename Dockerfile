FROM ubuntu:19.10
RUN apt-get update && apt-get install -y build-essential openscad
COPY ./src /app/src/
COPY Makefile /app
WORKDIR /app
CMD make all_container