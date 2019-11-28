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

### Install IRIDA Tools

Upon setup completion, from within the [IRIDA ToolShed][irida-toolshed] in Galaxy, please find and install the following tools to Galaxy:

- [suite_snvphyl_1_0_1][suite_snvphyl_1_0_1]

If you want to import sequence data from IRIDA to Galaxy, install:

- [irida_galaxy_importer][irida-importer-irida-toolshed]
  - **NB: Please follow from [tool-connection-configuration] to configure [irida_galaxy_importer][irida-importer-irida-toolshed]**.

Once installed, you should see them show up in your list of installed tools (**Admin > Mange tools**).

### Deploying to OpenStack

*Please see [openstack-terraform](openstack-terraform/) to deploy to OpenStack using Terraform.*

[irida-importer-irida-toolshed]: http://irida.corefacility.ca/galaxy-shed/view/irida/irida_galaxy_importer/d82238b091f2
[suite_snvphyl_1_0_1]: https://irida.corefacility.ca/galaxy-shed/view/nml/suite_snvphyl_1_0_1/4841b7148c44
[irida-toolshed]: https://irida.corefacility.ca/galaxy-shed
[tool-connection-configuration]: https://github.com/phac-nml/irida-galaxy-importer#22-tool-connection-configuration
