FROM quay.io/bgruening/galaxy:20.05
LABEL Maintainer="combat-tb-help@sanbi.ac.za"

WORKDIR /galaxy-central

RUN add-tool-shed --url 'http://testtoolshed.g2.bx.psu.edu/' --name 'Test Tool Shed'; \
	add-tool-shed --url 'https://irida.corefacility.ca/galaxy-shed/' --name 'IRIDA Tool Shed'

ENV GALAXY_CONFIG_BRAND="COMBAT-TB Workbench" \
	GALAXY_CONFIG_CONDA_ENSURE_CHANNELS="iuc,conda-forge,bioconda,defaults" 

RUN sed -i -e 's/# *admin_users: .*/admin_users: admin@galaxy.org/' /etc/galaxy/galaxy.yml; \
	sed -i -e 's/#\( *allow_path_paste:\).*/\1 true/' /etc/galaxy/galaxy.yml; \
	sed -i -e 's/# *conda_ensure_channels: .*/conda_ensure_channels: iuc,conda-forge,bioconda,defaults/' /etc/galaxy/galaxy.yml

# Adding the tool definitions to the container
COPY combattb-tools.yml $GALAXY_ROOT/
# Install deepTools
RUN install-tools $GALAXY_ROOT/combattb-tools.yml

USER galaxy

# Container Style
COPY *.png welcome.html $GALAXY_CONFIG_DIR/web/
