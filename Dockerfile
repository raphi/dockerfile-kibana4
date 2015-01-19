FROM java:openjdk-7u71-jre
MAINTAINER Raphael Daguenet <raphael.daguenet gmail com>

RUN apt-get update -q && DEBIAN_FRONTEND=noninteractive apt-get install -y curl git-core rubygems && \
	apt-get clean

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN curl -sSL https://get.rvm.io | bash -s stable

RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs

RUN echo 'source /usr/local/rvm/scripts/rvm' >> /etc/bash.bashrc
RUN /bin/bash -l -c rvm requirements
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c 'rvm install 1.9.3'
RUN /bin/bash -l -c 'rvm use 1.9.3 --default'
RUN /bin/bash -l -c 'gem install bundler --no-doc --no-ri'

RUN git clone --depth 1 https://github.com/raphi/kibana.git

WORKDIR kibana

RUN /bin/bash -l -c 'bundle'
RUN npm install -g grunt-cli bower
RUN npm install && bower --allow-root install

RUN grunt build

RUN mv build/dist/kibana /app
WORKDIR /
RUN rm -r /kibana

ADD start.sh /start.sh
RUN chmod +x /start.sh
CMD '/start.sh'
EXPOSE 5601
