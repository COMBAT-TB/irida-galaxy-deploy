# Docker - IRIDA

This IRIDA docker installation is configured for [ctbgx.sanbi.ac.za](http://ctbgx.sanbi.ac.za) and [irida-demo.sanbi.ac.za](http://irida-demo.sanbi.ac.za).

## NOTE

It mounts `/cip0/software/galaxy/cbtgalaxydev/cbtgx/irida/data` to the `iridaweb` container. You might want to change this to `/tmp/irida/data` using the `IRIDA_DATA_DIR` *ENV* in the `Dockerfile` if you are running it locally.

Port `80` is exposed.

## Up and running


```
$ docker-compose up -d
```
