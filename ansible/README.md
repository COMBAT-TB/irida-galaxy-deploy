# IRIDA ansible playbook

IRIDA ansible playbook

## Invoking the playbook

Set the following ceph keys for `/projects/irida/` and `projects/irida-dev`:

```sh
$ #/projects/irida-dev/
$ export IRIDA_DEV_CEPH_KEY=theiridadevcephkey
$ #/projects/irida/
$ export IRIDA_CEPH_KEY=theiridacephkey
```

_Take note of the IP addresses in the [`hosts`](./hosts) file._

```sh
$ ansible-playbook -u ubuntu -i hosts site.yml
```

<!-- ansible-playbook -e ansible_ssh_private_key_file=~/Downloads/irida.pem -u ubuntu -i ansible/hosts ansible/site.yml -->
