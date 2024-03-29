FROM tomcat:9.0.65-jre8
LABEL Maintainer="combat-tb-help@sanbi.ac.za"

ARG USER=galaxy
ARG UID=1450
ARG GID=1450
# default password for user
ARG PW=galaxy

RUN apt-get update; \
	apt-get -y upgrade; \
	apt-get install -f ; \
	apt-get install wget gosu perl fastqc nginx-full -y; \
	rm -rf /var/lib/apt/lists/*; \
	gosu nobody true; \
	mkdir -p /etc/irida/plugins

RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | \
	chpasswd

ENV	IRIDA_DOWNLOAD_URL="https://github.com/phac-nml/irida/releases/download/" \
	IRIDA_VERSION="21.05" \
	IRIDA_DATA_DIR=/data/irida \
	JAVA_OPTS="-Dspring.profiles.active=prod -Dirida.db.profile=prod" \
	GALAXY_ADMIN_USER="admin@galaxy.org"

RUN mkdir -p $IRIDA_DATA_DIR; \
	bash -c "mkdir -p ${IRIDA_DATA_DIR}/{sequence,reference,output,assembly}"; \
	wget "${IRIDA_DOWNLOAD_URL}/${IRIDA_VERSION}/irida-${IRIDA_VERSION}.war"; \
	mv irida-${IRIDA_VERSION}.war /usr/local/tomcat/webapps/ROOT.war

USER ${USER}

VOLUME $IRIDA_DATA_DIR

USER root

COPY *.conf /etc/irida/
COPY *.sh ./

COPY etc-irida/static /etc/irida/static
COPY etc-irida/templates /etc/irida/templates

COPY nginx-config /etc/nginx/sites-available/default
COPY start-daemons.sh /usr/local/bin/start-daemons.sh
RUN chmod a+x /usr/local/bin/start-daemons.sh

COPY workflows/* /etc/irida/plugins/

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["./wait-for-it.sh", "irida_mysql:3306", "--", "/usr/local/bin/start-daemons.sh"]
