FROM openjdk

MAINTAINER Andrew Taranik <me@pureclouds.net>

WORKDIR /nutch

ENV NUTCH_VER  2.3.1
ENV SEEDLIST   http://nutch.apache.org/
ENV MONGO_HOST mongo
ENV MONGO_PORT 27017

# Install dependecies and download nutch
RUN apt-get -yq update \
 && apt-get -yq install ant \
 && git clone https://github.com/apache/nutch.git /nutch \
 && git checkout branch-${NUTCH_VER}

ADD config/ivy.xml /nutch/ivy/ivy.xml
ADD config/nutch-site.xml /nutch/conf/nutch-site.xml
RUN ant runtime

# Copy required config
ADD config/gora.properties     /nutch/runtime/local/conf/gora.properties
ADD config/regex-urlfilter.txt /nutch/runtime/local/conf/regex-urlfilter.txt

# Start nutch webserver for controlling with REST API
EXPOSE 8081
CMD [ "/nutch/runtime/local/bin/nutch", "nutchserver" ]
