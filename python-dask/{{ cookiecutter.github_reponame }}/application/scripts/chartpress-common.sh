#!/bin/sh

# from https://github.com/jupyterhub/binderhub/blob/3ccb21af73b8a42ea44226b6e5cd5c8b94bf2fdc/ci/common

setup_helm() {
    helm_version="${1}"
    echo "setup helm ${helm_version}"
    curl -sf https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | DESIRED_VERSION="${helm_version}" bash
}
