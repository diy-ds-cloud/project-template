FROM python:3.9-slim
# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook jupyterlab && \
    pip install --no-cache \
        nbgitpuller \
        click \
        pyyaml \
        https://github.com/cookiecutter/cookiecutter/archive/refs/tags/2.0.2.tar.gz

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

# create user with a home directory
ARG NB_USER=jovyan
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}

COPY --chown=${NB_UID}:${NB_GID} . ${HOME}/work

USER ${NB_USER}
ENV SHELL /bin/bash
RUN . ./work/binder/postBuild