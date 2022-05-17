FROM jupyter/minimal-notebook:aa14e4498c6b

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}/work
USER root
RUN chown -R ${NB_UID} ${HOME}/work

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl gnupg && \
    \
    curl https://cli.github.com/packages/githubcli-archive-keyring.gpg | apt-key add - && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    curl https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    \
    echo "deb [arch=amd64] https://cli.github.com/packages stable main" | \
        tee /etc/apt/sources.list.d/github.list > /dev/null && \
    echo "deb [arch=amd64] https://packages.cloud.google.com/apt cloud-sdk main" | \
        tee /etc/apt/sources.list.d/google-cloud-sdk.list > /dev/null && \
    echo "deb [arch=amd64] https://apt.releases.hashicorp.com focal main" | \
        tee /etc/apt/sources.list.d/terraform.list > /dev/null && \
    \
    apt-get update && \
    apt-get install gh google-cloud-cli terraform

# RUN \
#     apt-get update && \
#     apt-get install -y --no-install-recommends curl neovim apt-transport-https ca-certificates gnupg zsh tree && \
#     \
#     # add GitHub cli repository
#     curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | \
#         gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
#     echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | \
#         tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
#     \
#     echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
#         tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
#     curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
#         apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
#     \
#     curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
#     echo "deb [arch=amd64] https://apt.releases.hashicorp.com focal main" | \
#         tee /etc/apt/sources.list.d/terraform.list > /dev/null && \
#     apt-get update && \
#     apt-get install -y gh && \
#     apt-get update && \
#     apt-get install -y google-cloud-cli && \
#     apt-get update && \
#     apt-get install terraform
# 
#     # enable zsh for user
#     usermod --shell /bin/zsh ${NB_USER} && \
#     \

USER ${NB_USER}

RUN pip install --no-cache-dir https://github.com/cookiecutter/cookiecutter/archive/refs/tags/2.0.2.tar.gz

RUN jupyter lab workspace import ${HOME}/work/binder/jupyterlab.workspace
