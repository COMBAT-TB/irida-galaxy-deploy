# Galaxy - SANBI-Zahra-Pipeline
#
# VERSION       0.2

FROM bgruening/galaxy-stable

MAINTAINER Zipho Mashologu, zipho@sanbi.ac.za

ENV GALAXY_CONFIG_BRAND COMBAT-TB ANALYSIS
ENV ENABLE_TTS_INSTALL True
# Enable Conda dependency resolution
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL=True \
    GALAXY_CONFIG_CONDA_AUTO_INIT=True

# Specifying Data Directories
RUN mkdir /export/library_import/ && chown $GALAXY_USER:$GALAXY_USER /export/library_import
ENV GALAXY_CONFIG_LIBRARY_IMPORT_DIR=/export/library_import
ENV GALAXY_CONFIG_ALLOW_LIBRARY_PATH_PASTE=True

WORKDIR /galaxy-central

#Speficy admin users
ENV GALAXY_CONFIG_ADMIN_USERS=admin@galaxy.org,zipho@sanbi.ac.za,pvh@sanbi.ac.za,thoba@sanbi.ac.za

# Add local conda channel
# Install miniconda to /miniconda
RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

RUN conda config --add channels http://conda.sanbi.ac.za/conda

RUN add-tool-shed --url 'http://testtoolshed.g2.bx.psu.edu/' --name 'Test Tool Shed'

# Install Visualisation
RUN install-biojs msa
# Adding the tool definitions to the container
ADD my_tool_list.yml $GALAXY_ROOT/my_tool_list.yml

# Install Zahra-Pipeline-Tools
RUN install-tools $GALAXY_ROOT/my_tool_list.yml

ADD galaxy_sanbi_wf.yaml $GALAXY_ROOT/workflows.yaml
RUN install-tools $GALAXY_ROOT/workflows.yaml

# Container Style
ADD GalaxyDocker.png $GALAXY_ROOT/static/welcome_image.png
ADD welcome.html $GALAXY_ROOT/static/welcome.html

# Data libraries
ADD setup_data_libraries.py $GALAXY_ROOT/setup_data_libraries.py
ADD library_data.yaml $GALAXY_ROOT/library_data.yaml

# Hacky script to import workflows into Galaxy after installation. I would argue this step is redundant.
ADD import_workflows.py $GALAXY_ROOT/import_workflows.py

# Both files will not be needed, but the latest changes are not in the 16.04 release.
ADD startup_lite.sh /usr/bin/startup_lite
RUN chmod +x /usr/bin/startup_lite

# Download training data and populate the data library
RUN startup_lite && \
    sleep 30 && \
    . $GALAXY_VIRTUAL_ENV/bin/activate && \
    python $GALAXY_ROOT/setup_data_libraries.py -i $GALAXY_ROOT/library_data.yaml && \
    python $GALAXY_ROOT/import_workflows.py

# Mark folders as imported from the host.
VOLUME ["/export/", "/data/", "/var/lib/docker"]

# Expose port 80 (webserver), 21 (FTP server), 8800 (Proxy)
EXPOSE :80
EXPOSE :21
EXPOSE :8800

# Autostart script that is invoked during container start
CMD ["/usr/bin/startup"]
