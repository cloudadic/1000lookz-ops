FROM ubuntu:latest
MAINTAINER Shan <shan@cloudadic.com>

RUN apt-get update && apt-get install python python-pip libmysqld-dev -y

ADD . /opt

WORKDIR /opt/3dapi

RUN python manage.py db upgrade

CMD ["python","manage.py","runserver"]
