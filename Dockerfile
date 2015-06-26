FROM microsoft/aspnet:1.0.0-beta4

RUN apt-get update && \
  apt-get install -y unzip libaio-dev && \
  apt-get -qq update && apt-get -qqy install unzip supervisor && \
  apt-get clean -y 

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

ADD . /src
WORKDIR /src

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN dnu restore 

EXPOSE 5004
CMD ["/usr/bin/supervisord"]