FROM jupyter/base-notebook:aa14e4498c6b

RUN pip install --no-cache-dir \
    nbgitpuller \
    click \
    pyyaml \
    https://github.com/cookiecutter/cookiecutter/archive/refs/tags/2.0.2.tar.gz

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-client curl gnupg && \
    \
    # add github cli repository
    curl https://cli.github.com/packages/githubcli-archive-keyring.gpg | apt-key add - && \
    echo "deb [arch=amd64] https://cli.github.com/packages stable main" > \
        /etc/apt/sources.list.d/github.list && \
    \
    # add google cloud cli repository
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb [arch=amd64] https://packages.cloud.google.com/apt cloud-sdk main" > \
        /etc/apt/sources.list.d/google-cloud-sdk.list && \
    \
    # add terraform cli repository
    curl https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://apt.releases.hashicorp.com focal main" > \
        /etc/apt/sources.list.d/terraform.list && \
    \
    # install gh, gcloud, and terraform
    apt-get update && \
    apt-get install -y --no-install-recommends \
        gh google-cloud-cli terraform

RUN \
    # install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl && \
    \
    # install helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

COPY --chown=${NB_UID}:${NB_GID} . ${HOME}/work

USER ${NB_USER}

RUN source work/binder/postBuild