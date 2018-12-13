FROM chef/chefdk:3.5.13

LABEL Maintainer="gmlp.24a@gmail.com"

ARG DOCKER_VERSION="17.12.1" 

RUN gem install kitchen-ec2 