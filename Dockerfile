FROM ubuntu:focal

RUN apt-get -y update && \
    apt-get -y upgrade && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install --no-install-recommends -y \
        bzr \
        ruby-full \
        python3-pip \
        lcov \
        cppcheck \
        uncrustify \
        bison \
        flex \
        wget \
        gcc-multilib \
        g++-multilib \
        build-essential \
        tzdata \
        python-backports.functools-lru-cache && \
    gem install ceedling && \
    pip install gcovr && \
    pip install gitlint && \
    rm -rf /var/lib/apt/lists/*

# Download, build and install cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1.tar.gz && \
    tar -xvzf cmake-3.21.1.tar.gz
RUN cd cmake-3.21.1 && \
    ./bootstrap -- -DCMAKE_USE_OPENSSL=OFF && make && make install && \
    cmake --version && \
    rm -f /cmake-3.21.1.tar.gz

RUN wget http://www.spinroot.com/uno/uno_v214.tar.gz && \
    tar -xf uno_v214.tar.gz && cd uno/src && \
    cf='-DPC -ansi -Wall -ggdb -DCPP="\\"gcc -E\\"" -DBINDIR=\\"$(BINDIR)\\"' && \
    sed -i "s/^CFLAGS=.*/CFLAGS=${cf}/" makefile && \
    make && make install && \
    uno -V | grep -q "Version 2.14" && test $? && \
    cd / && rm -f uno_v214.tar.gz

# Download, build and install infer
RUN VERSION=1.1.0 && \
    wget https://github.com/facebook/infer/releases/download/v$VERSION/infer-linux64-v$VERSION.tar.xz && \
    tar xvf infer-linux64-v$VERSION.tar.xz -C /opt/ && \
    ln -s "/opt/infer-linux64-v$VERSION/bin/infer" /usr/local/bin/infer

WORKDIR /usr/project
