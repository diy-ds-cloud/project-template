ARG BUILD_STAGE=worker

# FROM jupyter/r-notebook:b6fdd5dae6cb as worker
FROM jupyter/r-notebook:aa14e4498c6b as worker

ARG DIR_PREFIX=.

COPY --chown=${NB_UID}:${NB_GID} \
    ${DIR_PREFIX}/etc/future-vars.sh /opt/conda/bin/future-vars.sh

COPY --chown=${NB_UID}:${NB_GID} . ${HOME}/work/

RUN Rscript -e "install.packages(c('future', 'future.apply','doFuture'), repos='http://cran.us.r-project.org')"

FROM worker as rstudio

ARG DIR_PREFIX=.

RUN pip install --no-cache-dir \
        jupyter-server-proxy==3.2.0 \
        jupyter-rsession-proxy==2.0.1 && \
    jupyter labextension install @jupyterlab/server-proxy@3.2.0 && \
    jupyter lab build

USER root

RUN curl --silent -L --fail \
        https://download2.rstudio.org/server/bionic/amd64/rstudio-server-2021.09.1-372-amd64.deb > /tmp/rstudio.deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends /tmp/rstudio.deb && \
    rm /tmp/rstudio.deb && \
    apt-get clean

COPY --chown=${NB_UID}:${NB_GID} . ${HOME}/work/

FROM ${BUILD_STAGE} AS final

USER ${NB_UID}
