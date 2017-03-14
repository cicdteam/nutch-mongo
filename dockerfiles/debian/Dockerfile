FROM openjdk:8
MAINTAINER Andrew Taranik <me@pureclouds.net>

ENV WORKDIR    /nutch
ENV NUTCH_VER  2.3.1

# Download Nutch sources and compile them with custom ivy.yml
ADD ivy/ivy.xml /tmp/ivy.xml
RUN apt-get -yq update \
 && apt-get -yq install \
        ant \
 && curl -sSL http://www-us.apache.org/dist/nutch/${NUTCH_VER}/apache-nutch-${NUTCH_VER}-src.tar.gz | tar xz -C / \
 && mv -f /tmp/ivy.xml /apache-nutch-${NUTCH_VER}/ivy/ivy.xml \
 && ant -q -f /apache-nutch-${NUTCH_VER}/build.xml runtime \
 && mkdir -p ${WORKDIR} \
 && cp -rf /apache-nutch-${NUTCH_VER}/runtime/local/lib     ${WORKDIR} \
 && cp -rf /apache-nutch-${NUTCH_VER}/runtime/local/bin     ${WORKDIR} \
 && cp -rf /apache-nutch-${NUTCH_VER}/runtime/local/bin     ${WORKDIR} \
 && cp -rf /apache-nutch-${NUTCH_VER}/runtime/local/conf    ${WORKDIR} \
 && cp -rf /apache-nutch-${NUTCH_VER}/runtime/local/plugins ${WORKDIR} \
 && chmod +x ${WORKDIR}/bin/* \
 && rm -rf /apache-nutch-${NUTCH_VER} \
 && apt-get -yq purge \
        ant \
 && apt-get -yq autoremove

# Copy required config
ADD conf/nutch-site.xml      ${WORKDIR}/conf/nutch-site.xml
ADD conf/gora.properties     ${WORKDIR}/conf/gora.properties
ADD conf/regex-urlfilter.txt ${WORKDIR}/conf/regex-urlfilter.txt

# Copy seeds
ADD urls /urls

ENV PATH ${WORKDIR}/bin:${PATH}
WORKDIR ${WORKDIR}

# Copy shell scipts to run nutch
ADD scripts/*.sh ${WORKDIR}/bin/

# Default count of iterations
ENV ITERATIONS 10

CMD [ "run.sh" ]
