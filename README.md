# docker-irida-galaxy 

 A Dockerized IRIDA-Galaxy installation configured to be deployed on a single instance/VM.

:whale: [![Docker Repository on Quay](https://quay.io/repository/combat-tb/irida/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/irida) [![Docker Repository on Quay](https://quay.io/repository/combat-tb/irida/status "Docker Repository on Quay")](https://quay.io/repository/combat-tb/irida)

## Up and running

### Using docker-compose

**Assumption :**

- You have [`docker`](https://docs.docker.com/install/) and [`docker-compose`](https://docs.docker.com/compose/) installed on destination instance/VM.

```sh
$ ssh USER@REMOTE.SERVER
$ git clone https://github.com/COMBAT-TB/irida-galaxy-deploy.git
$ cd irida-galaxy-deploy
$ docker-compose up -d
...
```

This will take a couple of minutes.. :watch: :coffee:

Upon completion, point your browser to:

- [REMOTE.SERVER:8080/irida/](http://REMOTE.SERVER:8080/irida/) to access IRIDA
- [REMOTE.SERVER:9090](http://REMOTE.SERVER:9090/) to access Galaxy

The default administrator **username and password** are:

- `admin:password1`for IRIDA
- `admin:admin` for Galaxy

### Deploying to OpenStack

**Please see [README](openstack-terraform/README.md) for Terraform setup and take note of the FLOATING-IP.**
