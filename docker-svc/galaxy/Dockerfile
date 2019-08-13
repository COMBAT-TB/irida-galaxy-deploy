FROM quay.io/bgruening/galaxy:19.01
LABEL Maintainer="thoba@sanbi.ac.za"

WORKDIR /galaxy-central

RUN add-tool-shed --url 'http://testtoolshed.g2.bx.psu.edu/' --name 'Test Tool Shed'; \
	add-tool-shed --url 'https://irida.corefacility.ca/galaxy-shed/' --name 'IRIDA Toolshed'

ENV GALAXY_CONFIG_BRAND="COMBAT-TB IRIDA" \
	GALAXY_CONFIG_CONDA_ENSURE_CHANNELS="thoba,iuc,conda-forge,bioconda,defaults" 

RUN sed -i -e 's/# *admin_users: .*/admin_users: admin@galaxy.org,thoba@sanbi.ac.za,pvh@sanbi.ac.za,zipho@sanbi.ac.za/' /etc/galaxy/galaxy.yml; \
	sed -i -e 's/#\( *allow_path_paste:\).*/\1 True/' /etc/galaxy/galaxy.yml; \
	sed -i -e 's/# *conda_ensure_channels: .*/conda_ensure_channels: thoba,iuc,conda-forge,bioconda,defaults/' /etc/galaxy/galaxy.yml

# Adding the tool definitions to the container
COPY combattb-tools.yml $GALAXY_ROOT/
# Install deepTools
RUN install-tools $GALAXY_ROOT/combattb-tools.yml

# Container Style
COPY welcome_image.png welcome.html $GALAXY_CONFIG_DIR/web/
