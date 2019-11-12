FROM gcc:latest
COPY README.md /
# Set up a tools dev dierctory
WORKDIR /home/dev
RUN apt-get -qq update \
    && apt-get -y install git bzr ruby-full python-pip \
                          lcov cppcheck \
    && gem install ceedling \
    && pip install gcovr
WORKDIR /usr/project
