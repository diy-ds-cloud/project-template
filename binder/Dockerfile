FROM jupyter/minimal-notebook:aa14e4498c6b

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}/work
USER root
RUN chown -R ${NB_UID} ${HOME}/work

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl gnupg && \
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
    apt-get install gh google-cloud-cli terraform

USER ${NB_USER}

RUN pip install --no-cache-dir https://github.com/cookiecutter/cookiecutter/archive/refs/tags/2.0.2.tar.gz

RUN jupyter lab workspace import ${HOME}/work/binder/jupyterlab.workspace
