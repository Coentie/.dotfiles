FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install ansible

WORKDIR src

entrypoint ["ansible-vault"]