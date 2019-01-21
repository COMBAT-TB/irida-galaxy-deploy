FROM tomcat:8.0.36-jre8
MAINTAINER Thoba Lose "thoba@sanbi.ac.za"
LABEL Name=galaxy-irida Version="0.1"

RUN apt-get update; \
    apt-get -y upgrade; \
    apt-get install -f ; \
    apt-get install perl fastqc -y; \
    rm -rf /var/lib/apt/lists/*; \
    mkdir /etc/irida/

ENV GOSU_VERSION 1.10
RUN set -ex; \
	apt-get install -y --no-install-recommends ca-certificates; \
	rm -rf /var/lib/apt/lists/*; \
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	chmod +x /usr/local/bin/gosu; \
	gosu nobody true;

ENV IRIDA_DATA_DIR /data

#Irida

RUN mkdir -p $IRIDA_DATA_DIR/irida

RUN wget \
	https://github.com/SANBI-SA/irida/releases/download/sanbi-bvc-test/irida-0.17.1.war

RUN mv irida-0.17.1.war /usr/local/tomcat/webapps/irida.war

RUN bash -c 'mkdir ${IRIDA_DATA_DIR}/irida/sequence'
RUN bash -c 'mkdir ${IRIDA_DATA_DIR}/irida/reference'
RUN bash -c 'mkdir ${IRIDA_DATA_DIR}/irida/output'

VOLUME $IRIDA_DATA_DIR

ENV JAVA_OPTS="-Dspring.profiles.active=prod -Ddandelion.profile.active=prod"
ENV GALAXY_ADMIN_USER zipho@sanbi.ac.za

COPY irida.conf web.conf /etc/irida/
COPY wait-for-it.sh .
COPY docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["./wait-for-it.sh", "iridadb:3306", "--", "catalina.sh", "run"]

