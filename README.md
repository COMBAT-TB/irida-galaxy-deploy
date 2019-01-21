# Deploying a IRIDA instance on OpenStack using Terraform

This provides a template for deploying a Irida instance on OpenStack.

**You will need to modify [`variables.tf`](./variables.tf) defaults.**

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

Install the [OpenStack CLI client](https://docs.openstack.org/newton/user-guide/common/cli-install-openstack-command-line-clients.html) and run the following:

_To get a list of usable floating IP pools run the command below and take note of the name:_

```
$ openstack network list --external
+--------------------------------------+----------+--------------------------------------+
| ID                                   | Name     | Subnets                              |
+--------------------------------------+----------+--------------------------------------+
| 1352e2cb-4bb1-44e8-a3fe-8f08ec73c2d5 | public1  | 165ab7e5-a9e4-414c-8cac-88cc127453f3 |
+--------------------------------------+----------+--------------------------------------+

```

_To get a list of images available for use run and take note of the name:_

```
$ openstack image list
```

Modify [`variables.tf`](./variables.tf) using the above.

Afterwards apply changes with:

```
$ terraform apply -var 'pool=public1'
...
Outputs:

address = FLOATING-IP
```

Upon completion, the above command will output the instances floating IP address.

You will then point your browser to [http://FLOATING-IP:8080](http://FLOATING-IP:8080) to access the Irida database web interface!
