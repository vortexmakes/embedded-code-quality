FROM throwtheswitch/madsciencelab:latest
COPY README.md /
# Set up a tools dev dierctory
WORKDIR /home/dev
RUN apk --no-cache add \
#        lcov \
        cppcheck \
        uncrustify
WORKDIR /usr/project
