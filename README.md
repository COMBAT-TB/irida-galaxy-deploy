# docker-irida-galaxy

 A Dockerized IRIDA-Galaxy installation configured to be deployed on a single instance/VM.

## Up and running

### Prerequisites

- [`docker`](https://docs.docker.com/install/)
- [`docker-compose`](https://docs.docker.com/compose/)

### Specs

This setup was tested on a VM with the following specs.

- 32G RAM
- 4 vCPU
- 250G Disk

### Using docker-compose

**Assumption :**

- You have [`docker`](https://docs.docker.com/install/) and [`docker-compose`](https://docs.docker.com/compose/) installed on destination instance/VM.

>#### NOTE:
>You can use [scripts](scripts/) to install docker and deploy this stack.

Connect to the server where you want to install the Workbench:

```sh
ssh USER@REMOTE.SERVER
```

```sh
git clone https://github.com/COMBAT-TB/irida-galaxy-deploy.git ; cd irida-galaxy-deploy
```

### Install tools needed by workflows

The 'new style' [irida-plugin-builder](https://github.com/COMBAT-TB/irida-plugin-builder) bundles a `tools.yaml` with each pipeline in the pipeline jar file. The [TB Sample Report](https://github.com/COMBAT-TB/irida-plugin-tb-sample-report) and [TB Phylogeny](https://github.com/COMBAT-TB/irida-plugin-tb-phylogeny) pipelines are built using this builder and for each release a pipeline is
published on the corresponding Github repositories.

This repository includes a script `update_plugins_and_tools.py` (a Python3 script) that can download these plugins and configure the collection of tools to be installed into Galaxy. This tool takes as input a list of workflows to download (see `workflows.txt`) and optionally some extra Galaxy tools not mentioned in the workflows (see `extra-galaxy-tools.yml`). Here is a typical run of this tool:

```bash
./update_plugins_and_tools.py --extra_tools_file extra-galaxy-tools.yml workflows.txt
```

This should be run *before* the `docker-compose up` command and whenever workflows are updated or new ones added. It will require rebuilding the Docker containers i.e. `docker-compose up --build -d`. The `update_plugins_and_tools.py` script also has an option `--remove_old_workflows` that will delete all workflows in the workflow directory before downloading new ones. This should be used when new versions of workflows are downloaded.

### Start the Workbench

For the first time you start the Workbench

```sh
docker-compose up --build -d
```

To shut down the Workbench (again from the same directory where the Workbench code is installed):

```sh
docker-compose down
```

To start the Workbench again:

```
docker-compose up -d
```

>#### NOTE:
>This will take a couple of minutes.. :watch: :coffee:

Upon completion, point your browser to:

- [REMOTE.SERVER:8080/irida/](http://REMOTE.SERVER:8080/irida/) to access IRIDA
- [REMOTE.SERVER:9090](http://REMOTE.SERVER:9090/) to access Galaxy

The default administrator **username and password** are:

- **`admin:password1`** for IRIDA
- **`admin:admin`** for Galaxy

### Deploying to OpenStack

*Please see [openstack-terraform](openstack-terraform/) to deploy to OpenStack using Terraform.*
