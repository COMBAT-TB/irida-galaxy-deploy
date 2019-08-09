# Deploying IRIDA and Galaxy on a single OpenStack instance using Terraform

This provides a template for deploying [IRIDA](https://www.irida.ca/) and [Galaxy](https://galaxyproject.org/) on a single OpenStack instance using Terraform.

**You will need to modify [`variables.tf`](./variables.tf) defaults.**

## Usage

Download and install [Terraform](https://www.terraform.io/downloads.html):

```sh
$ wget -P /tmp/ https://releases.hashicorp.com/terraform/0.12.6/terraform_0.12.6_linux_amd64.zip
--
$ unzip /tmp/terraform_0.12.6_linux_amd64.zip
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

Install the [OpenStack CLI client](https://docs.openstack.org/newton/user-guide/common/cli-install-openstack-command-line-clients.html) and run the following:

_To get a list of usable floating IP pools run the command below:_

```sh
$ openstack network list --external
+--------------------------------------+----------+--------------------------------------+
| ID                                   | Name     | Subnets                              |
+--------------------------------------+----------+--------------------------------------+
| 1352e2cb-4bb1-44e8-a3fe-8f08ec73c2d5 | public1  | 165ab7e5-a9e4-414c-8cac-88cc127453f3 |
+--------------------------------------+----------+--------------------------------------+

```

_To get a list of images available for use run the following command:_

```sh
$ openstack image list
...
```

_To get a list of flavors available for use run the following command:_

```sh
$ openstack flavor list
...
```

_To get a list of available security groups run the following command:_

```sh
$ openstack security group list
...
```

**Modify [`variables.tf`](./variables.tf) using the above**.

Afterwards apply changes with:

```sh
$ terraform apply
...
```

This will take a couple of minutes... :watch: :coffee: -

Upon completion, the above command will output the instances floating IP address, which can also be viewed in `instance_ip.txt`.

Point your browser to:

- [FLOATING-IP:8080/irida/](http://FLOATING-IP:8080/irida/) to access IRIDA
- [FLOATING-IP:9090](http://FLOATING-IP:9090/) to access Galaxy

The default administrator **username and password** are:

- `admin:password1`for IRIDA
- `admin:admin` for Galaxy
