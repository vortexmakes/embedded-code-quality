FROM gcc:8.3.0

RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install --no-install-recommends -y \
        bzr \
        ruby-full \
        python-pip \
        lcov \
        cppcheck \
        uncrustify \
        bison \
        flex \
        python-backports.functools-lru-cache && \
    gem install ceedling && \
    pip install gcovr && \
    pip install gitlint && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://www.spinroot.com/uno/uno_v214.tar.gz && \
    tar -xf uno_v214.tar.gz && cd uno/src && \
    cf='-DPC -ansi -Wall -ggdb -DCPP="\\"gcc -E\\"" -DBINDIR=\\"$(BINDIR)\\"' && \
    sed -i "s/^CFLAGS=.*/CFLAGS=${cf}/" makefile && \
    make && make install && \
    uno -V | grep -q "Version 2.14" && test $? && \
    cd / && rm -f uno_v214.tar.gz

WORKDIR /usr/project
