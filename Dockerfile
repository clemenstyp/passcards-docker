FROM   ubuntu:latest
MAINTAINER	Clemens Putschli <clemens@putschli.de>

#Install node js
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y sudo
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y git
RUN apt-get install -y nodejs
RUN apt-get install -y npm 
RUN sudo apt-get install -y build-essential
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#install passcards
RUN cd /root && export GIT_SSL_NO_VERIFY=1 && \
    git config --global http.sslVerify false && \
    git clone https://github.com/robertknight/passcards

WORKDIR /root/passcards
RUN cd /root/passcards && npm install
RUN cd /root/passcards && make all


# Baseimage init process
CMD cd /root/passcards  && python -m SimpleHTTPServer 3000
