FROM jupyter/minimal-notebook:aa14e4498c6b

USER root

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends curl neovim apt-transport-https ca-certificates gnupg zsh && \
    \
    # install yadm
    git clone https://github.com/TheLocehiliosan/yadm.git /usr/local/share/yadm && \
    ln -s /usr/local/share/yadm/yadm /usr/local/bin/yadm && \
    \
    # install jq
    wget https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -O /opt/conda/bin/jq && \
    chmod a+x /opt/conda/bin/jq && \
    \
    # install gh (GitHub CLI)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
    apt-get update && \
    apt-get install -y gh && \
    \
    # enable zsh for user
    usermod --shell /bin/zsh ${NB_USER} && \
    \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && \
    apt-get install -y google-cloud-cli && \
    \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    echo "deb [arch=amd64] https://apt.releases.hashicorp.com focal main" | tee /etc/apt/sources.list.d/terraform.list > /dev/null && \
    apt-get update && \
    apt-get install terraform

RUN \
    # install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl && \
    \
    # install helm
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

USER ${NB_USER}

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    sed -i '/^[[:space:]]*$/d;/^#/d;s/^plugins=(git)/plugins=(gh git vi-mode docker gcloud kubectl helm)/' $HOME/.zshrc && \
    echo "bindkey 'jk' vi-cmd-mode" >> $HOME/.zshrc && \
    echo "export EDITOR='vim'" >> $HOME/.zshrc && \
    \
    pip install nbgitpuller click pyyaml

ENV SHELL=/usr/bin/zsh
