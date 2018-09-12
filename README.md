# Jenkins Test Lab
Lab environment for various Jenkins Tests

## Requirements

This environment uses vagrant to deploy a local Jenkins instance and windows worker node.

### Pre-requisites

* VirtualBox
* Vagrant
* Python

You will also need the [Vagrant Host Manager plugin](https://github.com/devopsgroup-io/vagrant-hostmanager), you can install it with the following command:

```
vagrant plugin install vagrant-hostmanager
```

See <https://github.com/devopsgroup-io/vagrant-hostmanager> for more information on this plugin.

This demo assumes that 192.168.100.0/24 is available for host only network use.  You will need to adjust the vagrantfile if this is not the case.