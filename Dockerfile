FROM   ubuntu:latest
MAINTAINER	Clemens Putschli <clemens@putschli.de>

#Install node js
RUN \
    sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y sudo && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && \
    apt-get install -y git && \
    apt-get install -y nodejs && \
    apt-get install -y npm && \
    sudo apt-get install -y build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#install passcards
RUN cd /root && export GIT_SSL_NO_VERIFY=1 && \
    git config --global http.sslVerify false && \
    git clone https://github.com/robertknight/passcards

WORKDIR /root/passcards
RUN cd /root/passcards && npm install
RUN cd /root/passcards && make all


# Baseimage init process
CMD cd /root/passcards  && python -m SimpleHTTPServer 3000
