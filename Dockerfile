FROM stlhrt/jdk8
MAINTAINER Lukasz Wozniak

# install supervisor
USER root
RUN apt-get update
RUN apt-get install -qy unzip supervisor

# prepare folders
RUN mkdir -p /opt/consul/conf && mkdir -p /opt/consul/logs && mkdir -p /opt/consul/data
WORKDIR /opt/consul

# get consul
ADD https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul && rm /tmp/consul.zip

# configure consul
ADD /supervisord-consul.conf /etc/supervisor/conf.d/supervisord-consul.conf
ADD /50-defaults.json /opt/consul/conf/50-defaults.json

#configure application launching
ADD supervisord-app.conf /etc/supervisor/conf.d/supervisord-app.conf

# Expose volume for additional serf config in JSON
VOLUME /opt/consul/conf
VOLUME /opt/consul/logs
VOLUME /opt/consul/data

ENV APP_CMD /bin/bash -c 'while true; do echo "Nothing..."; sleep 5; done'
ENV CONSUL_OPTS ""

CMD ["supervisord", "-n"]