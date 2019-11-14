FROM throwtheswitch/madsciencelab:latest
COPY README.md /
# Set up a tools dev dierctory
WORKDIR /home/dev
RUN apt-get -qq update \
    && apt-get -y install \
    && lcov cppcheck uncrustify
WORKDIR /usr/project
