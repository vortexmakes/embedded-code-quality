FROM gcc:8.3.0
COPY README.md /
# Set up a tools dev dierctory
WORKDIR /home/dev
RUN apt-get -qq update \
    && apt-get -y install bzr ruby-full python-pip \
                          lcov cppcheck uncrustify \
    && gem install ceedling \
    && pip install gcovr
WORKDIR /usr/project
