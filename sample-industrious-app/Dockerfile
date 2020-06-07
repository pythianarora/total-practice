FROM ubuntu
MAINTAINER sandeeparora <sandeep16arora@gmail.com>

RUN \
  DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata && \
  apt-get update && \
  apt-get -y install \
          apache2 && \
  rm /var/www/html/index.html && \
  rm -rf /var/lib/apt/lists/*
  


COPY . /var/www/html/

EXPOSE 8080

CMD /usr/sbin/apache2ctl -D FOREGROUND