FROM tomcat:latest
LABEL Maintainer="combat-tb-help@sanbi.ac.za"

ARG USER=galaxy
ARG UID=1450
ARG GID=1450
# default password for user
ARG PW=galaxy

RUN apt-get update; \
	apt-get -y upgrade; \
	apt-get install -f ; \
	apt-get install perl fastqc nginx-full -y; \
	rm -rf /var/lib/apt/lists/*; \
	mkdir -p /etc/irida/plugins

RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | \
	chpasswd

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

ENV COMBAT_TB_PLUGINS="https://github.com/COMBAT-TB/irida-pipeline-plugins" \
    IRIDA_DOWNLOAD_URL="https://github.com/phac-nml/irida/releases/download/" \
	IRIDA_VERSION="20.09.2" \
	IRIDA_DATA_DIR=/data/irida \
	JAVA_OPTS="-Dspring.profiles.active=prod -Dirida.db.profile=prod" \
	GALAXY_ADMIN_USER="admin@galaxy.org"

RUN mkdir -p $IRIDA_DATA_DIR; \
	bash -c "mkdir -p ${IRIDA_DATA_DIR}/{sequence,reference,output,assembly}"; \
	wget "${COMBAT_TB_PLUGINS}/releases/download/v0.2.3/tb-sample-report-pipeline-plugin-0.2.3-SNAPSHOT.jar"  -P /etc/irida/plugins/; \
	wget "${COMBAT_TB_PLUGINS}/releases/download/v0.1.2/snippy-tb-sample-iqtree-0.1.3.jar" -P /etc/irida/plugins/; \
	wget "${IRIDA_DOWNLOAD_URL}/${IRIDA_VERSION}/irida-${IRIDA_VERSION}.war"; \
	mv irida-${IRIDA_VERSION}.war /usr/local/tomcat/webapps/ROOT.war

USER ${USER}

VOLUME $IRIDA_DATA_DIR

USER root

COPY *.conf /etc/irida/
COPY etc-irida/static /etc/irida/static
COPY etc-irida/templates /etc/irida/templates
COPY *.sh ./

COPY nginx-config /etc/nginx/sites-available/default
COPY start-daemons.sh /usr/local/bin/start-daemons.sh
RUN chmod a+x /usr/local/bin/start-daemons.sh

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["./wait-for-it.sh", "irida_mysql:3306", "--", "/usr/local/bin/start-daemons.sh"]
