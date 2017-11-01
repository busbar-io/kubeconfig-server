# Kubeconfig Server

A simple service to allow [busbar-cli](https://github.com/busbar-io/busbar-cli) clients to retrieve the kubernetes config file

## Usage

The build_and_push.sh script will:

```
This script will copy the kubernetes configuration file in '~/.kube/config' to
the current folder, increment the version on the 'version.txt' file, build a docker image
and push it to the provided <private_docker_registry>

Usage:
     build_and_push.sh <private_docker_registry>
```

