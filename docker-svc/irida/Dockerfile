FROM tomcat:8.0.36-jre8
LABEL Maintainer="thoba@sanbi.ac.za"

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

RUN mkdir -p $IRIDA_DATA_DIR/irida; \
	wget https://github.com/phac-nml/irida/releases/download/19.05.1/irida-19.05.1.war; \
	mv irida-19.05.1.war /usr/local/tomcat/webapps/irida.war; \
	bash -c 'mkdir ${IRIDA_DATA_DIR}/irida/sequence'; \
	bash -c 'mkdir ${IRIDA_DATA_DIR}/irida/reference'; \
	bash -c 'mkdir ${IRIDA_DATA_DIR}/irida/output'

VOLUME $IRIDA_DATA_DIR

ENV JAVA_OPTS="-Dspring.profiles.active=prod -Ddandelion.profile.active=prod" \
	GALAXY_ADMIN_USER="admin@galaxy.org"

COPY irida.conf web.conf /etc/irida/
COPY wait-for-it.sh .
COPY docker-entrypoint.sh .

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["./wait-for-it.sh", "irida_mysql:3306", "--", "catalina.sh", "run"]
