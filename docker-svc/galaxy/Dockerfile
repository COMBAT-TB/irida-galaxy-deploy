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

# Adding the tool definitions and data manager to the container
COPY combattb-tools.yml snpeff_data_manager.yml $GALAXY_ROOT/

# Install Combact-TB Tools
RUN install-tools $GALAXY_ROOT/combattb-tools.yml && \
    /tool_deps/_conda/bin/conda clean --tarballs --yes > /dev/null && \
    rm /export/galaxy-central/ -rf && \
    mkdir -p $GALAXY_HOME/workflows

# Add galaxy to admin group
RUN usermod -a -G root galaxy

# Install data-manager (data_manager_snpeff)
RUN /tool_deps/_conda/bin/conda install ephemeris
RUN echo $GALAXY_DEFAULT_ADMIN_USER
RUN echo $GALAXY_DEFAULT_ADMIN_PASSWORD
RUN startup_lite && \
	/tool_deps/_conda/bin/run-data-managers -u admin@galaxy.org -p $GALAXY_DEFAULT_ADMIN_PASSWORD \
        -g http://localhost:8080 --config snpeff_data_manager.yml

# Container Style
COPY *.png welcome.html $GALAXY_CONFIG_DIR/web/
