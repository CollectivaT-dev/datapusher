FROM debian:jessie
MAINTAINER Open Knowledge

# Install required system packages
RUN apt-get -q -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade \
    && apt-get -q -y install \
        python-dev \
        python-pip \
        python-virtualenv \
        build-essential \
        libxslt1-dev \ 
        libxml2-dev \
        git \
    && apt-get -q clean \
    && rm -rf /var/lib/apt/lists/*

RUN virtualenv /usr/lib/ckan/datapusher
RUN mkdir /usr/lib/ckan/datapusher/src
COPY requirements.txt /usr/lib/ckan/datapusher/src
COPY requirement-setuptools.txt /usr/lib/ckan/datapusher/src
WORKDIR /usr/lib/ckan/datapusher/src
RUN /usr/lib/ckan/datapusher/bin/pip install -U pip && \
    /usr/lib/ckan/datapusher/bin/pip install --upgrade --no-cache-dir -r requirement-setuptools.txt && \
    /usr/lib/ckan/datapusher/bin/pip install --upgrade --no-cache-dir -r requirements.txt
COPY . /usr/lib/ckan/datapusher/src
RUN /usr/lib/ckan/datapusher/bin/pip install -e .

CMD [ "/usr/lib/ckan/datapusher/bin/python", "datapusher/main.py", "deployment/datapusher_settings.py"]