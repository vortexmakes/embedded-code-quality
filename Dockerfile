FROM gcc:8.3.0
COPY README.md /
WORKDIR /home/dev

RUN apt-get -qq update \
    && apt-get -y install bzr ruby-full python-pip \
                          lcov cppcheck uncrustify bison flex \
    && gem install ceedling \
    && pip install gcovr

RUN wget http://www.spinroot.com/uno/uno_v214.tar.gz && \
    tar -xf uno_v214.tar.gz && cd uno/src && \
    cf='-DPC -ansi -Wall -ggdb -DCPP="\\"gcc -E\\"" -DBINDIR=\\"$(BINDIR)\\"' && \
    sed -i "s/^CFLAGS=.*/CFLAGS=${cf}/" makefile && \
    make && make install && \
    uno -V | grep -q "Version 2.14" && test $?

WORKDIR /usr/project
