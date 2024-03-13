FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get autoremove -y \
 && apt-get autoclean -y \
 && apt-get install -y \
 sudo \
 nano \
 wget \
 curl \
 git \
 build-essential \
 gcc \
 openjdk-21-jdk \
 mono-complete \
 python3 \
 strace \
 valgrind
RUN useradd -G sudo -m -d /home/CORNELIA -s /bin/bash -p "$(openssl passwd -1 Lilla123)" CORNELIA
USER CORNELIA
WORKDIR /home/CORNELIA
RUN mkdir hacking \
 && cd hacking \
 && curl -SL https://raw.githubusercontent.com/uia-worker/is105misc/master/sem01v2 4/pawned.sh > pawned.sh \
 && chmod 764 pawned.sh \
 && cd ..
RUN git config --global user.email "corneliars@uia.no" \
 && git config --global user.name "Cornelia" \
 && git config --global url."https://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:@github.com/".insteadOf "https://github.com" \
 && mkdir -p github.com/corneliars/sem02v24
USER root
RUN curl -SL https://go.dev/dl/go1.21.7.linux-amd64.tar.gz \
 | tar xvz -C /usr/local
USER CORNELIA
SHELL ["/bin/bash", "-c"]
RUN mkdir -p $HOME/go/{src,bin}
ENV GOPATH="/home/CORNELIA/go"
ENV PATH="${PATH}:${GOPATH}/bin:/usr/local/go/bin"
RUN curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf \ 
 | sh -s -- -y
ENV PATH="${PATH}:${HOME}/.cargo/bin"
