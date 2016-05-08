FROM ubuntu:latest
MAINTAINER Shan <shan@cloudadic.com>

RUN apt-get update && apt-get install python python-pip libmysqld-dev -y

ADD . /opt

WORKDIR /opt/3dapi

RUN pip install -r requirements.txt

CMD ["./start.sh"]
