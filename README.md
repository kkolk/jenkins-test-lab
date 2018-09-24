# Jenkins Test Lab
Lab environment for various Jenkins Tests

## Requirements

This environment uses vagrant to deploy a local Jenkins instance and windows worker node.

### Pre-requisites

* VirtualBox
* Vagrant
* Python

You will also need the [Vagrant Host Manager plugin](https://github.com/devopsgroup-io/vagrant-hostmanager), [Vagrant Reload Provisioner](https://github.com/aidanns/vagrant-reload) and the [Vagrant Disk Size plugin](http://github.com/sprotheroe/vagrant-disksize/), you can install these with the following command once Vagrant is installed:

```
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-disksize
vagrant plugin install vagrant-reload
```

See <https://github.com/devopsgroup-io/vagrant-hostmanager>, <https://github.com/aidanns/vagrant-reload>, and <https://github.com/sprotheroe/vagrant-disksize> for more information on these plugins.   Without these plugins you will get errors regarding unknown configuration sections.

This demo assumes that 192.168.100.0/24 is available for host only network use.  You will need to adjust the vagrantfile and hostnames in the group_vars\all.yml if this is not the case.

## Getting Started

Open your terminal of choice and navigate to the folder you cloned the repo into.  Execute:

```
vagrant up
```

This will complete the following actions:

* Create a VM for Jenkins
* Install Jenkins
* Add plugins to Jenkins: 
  * powershell 
  * git
  * blueocean
  * workflow-aggregator
  * msbuild 
  * pipeline-multibranch
* Add Groovy scripts to Jenkins to:
  * Configure the MSBuild Tool
  * Create a Windows Worker Node
  * Set the TCP Worker Agent Port
* Create a VM for the Windows Worker Node
  * Install Java
  * Install Jenkins Agent
  * Connect Jenkins Agent to Jenkins Master
  * Configure Windows for Ansible
  * Install Chocolately for package management
  * Using Chocolately install:
    * ASP.Net MVC
    * git 
    * Microsoft .NET Framework
    * Microsoft Build Tools (from Visual Studio 2017)
      * Base build tools 
      * Workload: Web Build Tools
      * Workload: .NET Core Build Tools

Once completed you are now ready to log into Jenkins and add a .NET MVC application to be built on the Windows worker.

As a test I have a sample application from Microsoft cloned here with a JenkinsFile added which you can import as a new pipeline or multibranch pipeline project:

https://github.com/kkolk/mvc-music-store

Once added Jenkins should build the application successfully using MSBuild on the Windows worker node and then archive the resulting bin folder.