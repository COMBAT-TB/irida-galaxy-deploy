# docker-irida-galaxy

 A Dockerized IRIDA-Galaxy installation configured to be deployed on a single instance/VM.

:whale: [![Docker Repository on Quay](https://quay.io/repository/combat-tb/irida/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/irida) :whale: [![Docker Repository on Quay](https://quay.io/repository/combat-tb/irida/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/irida)

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

```sh
ssh USER@REMOTE.SERVER
```

```sh
git clone https://github.com/COMBAT-TB/irida-galaxy-deploy.git ; cd irida-galaxy-deploy
```

```sh
docker-compose -f stack.yml up -d
```

>#### NOTE:
>This will take a couple of minutes.. :watch: :coffee:

Upon completion, point your browser to:

- [REMOTE.SERVER:8080/irida/](http://REMOTE.SERVER:8080/irida/) to access IRIDA
- [REMOTE.SERVER:9090](http://REMOTE.SERVER:9090/) to access Galaxy

The default administrator **username and password** are:

- **`admin:password1`** for IRIDA
- **`admin:admin`** for Galaxy

### Install tools needed by workflows

The 'new style' [irida-plugin-builder](https://github.com/COMBAT-TB/irida-plugin-builder) bundles a `tools.yaml` with each pipeline in the pipeline jar file. The [TB Sample Report](https://github.com/COMBAT-TB/irida-plugin-tb-sample-report) and [TB Phylogeny](https://github.com/COMBAT-TB/irida-plugin-tb-phylogeny) pipelines are built using this builder and for each release a pipeline is
published on the corresponding Github repositories.

This repository includes a script `update_plugins_and_tools.py` (a Python3 script) that can download these plugins and configure the collection of tools to be installed into Galaxy. This tool takes as input a list of workflows to download (see `workflows.txt`) and optionally some extra Galaxy tools not mentioned in the workflows (see `extra-galaxy-tools.yml`). Here is a typical run of this tool:

```bash
./update_plugins_and_tools.py --extra_tools_file extra-galaxy-tools.yml workflows.txt
```

This should be run *before* the `docker-compose up` command and whenever workflows are updated or new ones added. It will require rebuilding the Docker containers i.e. `docker-compose up --build`. The `update_plugins_and_tools.py` script also has an optional
`--remove_old_workflows` script that will delete all workflows in the workflow directory before downloading new ones.

Once installed, you should see them show up in your list of installed tools (**Admin > Mange tools**).

### Deploying to OpenStack

*Please see [openstack-terraform](openstack-terraform/) to deploy to OpenStack using Terraform.*

[irida-importer-irida-toolshed]: http://irida.corefacility.ca/galaxy-shed/view/irida/irida_galaxy_importer/d82238b091f2
[suite_snvphyl_1_0_1]: https://irida.corefacility.ca/galaxy-shed/view/nml/suite_snvphyl_1_0_1/4841b7148c44
[irida-toolshed]: https://irida.corefacility.ca/galaxy-shed
[tool-connection-configuration]: https://github.com/phac-nml/irida-galaxy-importer#22-tool-connection-configuration
