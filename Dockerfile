FROM ubuntu:14.04
MAINTAINER Dmitry Kostyaev <dmitry@kostyaev.me>

RUN apt-get -y update && apt-get install -y \
python \
python-dev \
python-distribute \
python-pip \
libffi-dev \
libssl-dev \
libxml2-dev \
libxslt1-dev \
libjpeg8-dev \
python-all-dev \
libfreetype6-dev

COPY . /opt/image-turk/
#ADD https://dl.dropboxusercontent.com/u/40391687/api_credentials.py /opt/image-turk/searchtools/engines/

RUN mkdir -p /opt/image-turk/data
RUN pip install --upgrade pip setuptools
RUN pip install --ignore-installed -r /opt/image-turk/requirements.txt


WORKDIR /opt/image-turk/

EXPOSE 5000

CMD ["python", "image_turk.py"]
