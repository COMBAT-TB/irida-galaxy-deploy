# Deploying a Neo4j instance on OpenStack using Terraform

This provides a template for deploying a Neo4j instance on OpenStack.

_See [`variables.tf`](./variables.tf) for used defaults variables._

## Usage

Download and install [Terraform](https://www.terraform.io/downloads.html):

```sh
$ wget -P /tmp/ https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
--
$ unzip /tmp/terraform_0.11.8_linux_amd64.zip
$ sudo mv terraform /usr/local/bin/
$ terraform --version
```

Log in to the OpenStack dashboard, choose the project for which you want to download the OpenStack RC file, and run the following commands:

```sh
$ source ~/Downloads/PROJECT-openrc.sh
Please enter your OpenStack Password for project PROJECT as user username:
```

Initialize Terraform:

- Initialize a new or existing Terraform working directory by creating
  initial files, loading any remote state, downloading modules, etc.

```sh
$ terraform init
Initializing...
```

Generate an execution Plan:

- This execution plan can be reviewed prior to running apply to get a sense for what Terraform will do

```sh
$ terraform plan
...
```

Afterwards apply changes with:

```
$ terraform apply -var 'pool=public1'
...
Outputs:

address = FLOATING-IP
```

Upon completion, the above command will output the instances floating IP address.

You will then point your browser to [http://floatingip:7474](http://floatingip:7474) to access the Neo4j database web interface!

**To get a list of usable floating IP pools install the [OpenStack CLI client](https://docs.openstack.org/newton/user-guide/common/cli-install-openstack-command-line-clients.html) run the command below:**

```
$ openstack network list --external
+--------------------------------------+--------+----------------------------------------------------------------------------+
| ID                                   | Name   | Subnets                                                                    |
+--------------------------------------+--------+----------------------------------------------------------------------------+
| fd21df30-693b-496a-ac69-8637b9c24cd3 | public1 | a2d7c467-44f9-43c5-b387-8a6742f45b5c, ee51200c-9b64-4977-ad30-622039d7bba1 |
+--------------------------------------+--------+----------------------------------------------------------------------------+
```
