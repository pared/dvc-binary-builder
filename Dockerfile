FROM ubuntu:16.04

RUN apt-get update \ 
	&& apt-get install -y locales \
	&& rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get install -y python3.6
RUN apt-get install -y python3.6-dev
RUN apt-get install -y python3-pip
RUN apt-get install -y git vim 
RUN apt-get install -y curl

RUN git clone https://github.com/pared/vim_setup ~/vim_setup
RUN . ~/vim_setup/setup.sh

RUN python3.6 -m pip install virtualenv
RUN python3.6 -m virtualenv ~/env-dvc
RUN git clone https://github.com/iterative/dvc ~/dvc

RUN sed -i "s/sudo //g" ~/dvc/scripts/build_posix.sh

WORKDIR /root/dvc
RUN /bin/bash -c 'source /root/env-dvc/bin/activate && /bin/echo -e "Y\n" | ./scripts/build_posix.sh'






