#!/bin/bash

#
# build_and_push.sh - Build and push a Kubeconfig Docker Image
#

### Variables
private_docker_registry=$1
app_name='kubeconfig'


### Functions
usage() {
    echo
    echo "build_and_push.sh - Build and push a Kubeconfig Docker Image"
    echo
    echo "This script will copy the kubernetes configuration file in '~/.kube/config' to"
    echo "the current folder, increment the version on the 'version.txt' file, build a docker image"
    echo "and push it to the provided <private_docker_registry>"
    echo
    echo "Usage:"
    echo "     build_and_push.sh <private_docker_registry>"
    echo
}

### Parameter validation
if [ $# -ne 1 ]; then
    usage
    exit 1
fi

### Action! o/
# Copy config file
cp ~/.kube/config ./kube.config

# Increment version number on version.txt file
current_versions=$(curl --silent  http://${private_docker_registry}/v2/${app_name}/tags/list)
echo $current_versions | jq .tags | grep -v latest | tail -n 2 | grep -Eo '[0-9]' > version.txt

current_kubeconfig_version=$(cat version.txt)
new_kubeconfig_version=$(( $current_kubeconfig_version + 1 ))
echo $new_kubeconfig_version > version.txt

# Docker
version=$(cat version.txt)

docker build --rm --force-rm -t ${app_name}:${version} -t ${app_name}:latest .

docker tag ${app_name}:${version} ${private_docker_registry}/${app_name}:${version}
docker tag ${app_name}:latest ${private_docker_registry}/${app_name}:latest

docker push ${private_docker_registry}/${app_name}:${version}
docker push ${private_docker_registry}/${app_name}:latest

exit 0
