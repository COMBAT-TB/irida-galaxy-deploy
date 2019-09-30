FROM tomcat:8.0.36-jre8
LABEL Maintainer="thoba@sanbi.ac.za"

RUN apt-get update; \
	apt-get -y upgrade; \
	apt-get install -f ; \
	apt-get install perl fastqc -y; \
	rm -rf /var/lib/apt/lists/*; \
	mkdir -p /etc/irida/plugins

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

ENV COMBAT_TB="https://github.com/COMBAT-TB" \
	IRIDA_DOWNLOAD_URL="https://github.com/phac-nml/irida/releases/download" \
	IRIDA_VERSION="19.09" \
	IRIDA_DATA_DIR=/data/irida \
	JAVA_OPTS="-Dspring.profiles.active=prod -Ddandelion.profile.active=prod" \
	GALAXY_ADMIN_USER="admin@galaxy.org"

RUN mkdir -p $IRIDA_DATA_DIR; \
	wget "${IRIDA_DOWNLOAD_URL}/${IRIDA_VERSION}/irida-${IRIDA_VERSION}.war"; \
	mv irida-${IRIDA_VERSION}.war /usr/local/tomcat/webapps/irida.war; \
	bash -c 'mkdir -p ${IRIDA_DATA_DIR}/{sequence,reference,output}'

RUN wget "${COMBAT_TB}/irida-pipeline-plugins/releases/download/0.1.0/tb-vcf-report-pipeline-plugin-0.1.0-SNAPSHOT.jar" -P /etc/irida/plugins/

VOLUME $IRIDA_DATA_DIR

COPY *.conf /etc/irida/
COPY *.sh ./

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["./wait-for-it.sh", "irida_mysql:3306", "--", "catalina.sh", "run"]
