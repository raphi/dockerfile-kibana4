FROM java:openjdk-7u71-jre
MAINTAINER Raphael Daguenet <raphael.daguenet gmail com>

RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get install -y curl git-core zip bzip2 && \
	apt-get clean

RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

RUN git clone --depth 1 https://github.com/raphi/kibana.git

WORKDIR kibana

RUN npm install -g grunt-cli bower
RUN npm install && bower --allow-root install

RUN grunt build

RUN mkdir /app
RUN tar -zxf target/kibana-4.0.0*linux-x64.tar.gz -C /app
RUN rm -r /kibana

WORKDIR /app

ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD '/start.sh'
EXPOSE 5601