Dou Vault Installer Cookbook
====


This repo contains a cookbook to install hashicorp vault. This cookbook is base on GruntWork install_vault module.

## Tested platforms:

* RHEL 7 


This repo also includes:

* [Dockerfile](/Dockerfiles): Here, you are going to find the Dockerfile used in the CI pipeline flow. This image is available in Docker Hub [gmlpdou/terraform_hub](https://hub.docker.com/r/gmlpdou/terraform_hub/)

## How is tested project?


* [Jenkins_with_slave_CI_CD](https://github.com/gmlp/jenkins_with_slave_CI_CD): This repo brings up a Jenkins with all the required plugins.
* [Shared_library](https://github.com/gmlp/shared_library): The Jenkins pipeline requires of this shared library.

![chef_pipeline](/_docs/chef_pipeline.png?raw=true)

## Generator 

* [dou_generator](https://github.com/gmlp/dou_chef_generator). 