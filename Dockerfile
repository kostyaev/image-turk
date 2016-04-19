FROM ubuntu:14.04
MAINTAINER Dmitry Kostyaev <dmitry@kostyaev.me>

RUN apt-get -y update && \
apt-get install -y \
python \
python-dev \
python-distribute \
python-pip \
libffi-dev \
libssl-dev \
libxml2-dev \
libxslt1-dev \
libevent-dev \
python-all-dev \
libfreetype6-dev

COPY * /opt/image-turk/
WORKDIR /opt/image-turk/

RUN pip install -r requirements.txt

ADD requirements.txt /opt/

EXPOSE 5000

ENTRYPOINT ["python", "/opt/image-turk/image-turk.py"]