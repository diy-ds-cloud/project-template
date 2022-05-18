ARG BUILD_STAGE=worker

FROM jupyter/scipy-notebook:b6fdd5dae6cb AS worker

ARG DIR_PREFIX=.

COPY --chown=${NB_UID}:${NB_GID} . ${HOME}/work/

FROM worker AS notebook

ARG DIR_PREFIX=.

RUN mamba install --yes \
    dask-labextension>=5 \
    python-graphviz

# COPY --chown=1000:100 dask-config.yaml /home/jovyan/.config/dask/labextension-config.yaml
COPY --chown=${NB_UID}:${NB_GID} etc/dask-config.yaml /home/jovyan/.dask/labextension-config.yaml
COPY --chown=${NB_UID}:${NB_GID} etc/dask-dashboard.sh /usr/local/bin/start-notebook.d/dask-dashboard.sh
# COPY --chown=1000:100 dask-dashboard.sh /usr/local/bin/before-notebook.d/dask-dashboard.sh
COPY --chown=${NB_UID}:${NB_GID} etc/jupyterlab-workspace.json jupyterlab-workspace.json
# COPY --chown=${NB_UID}:${NB_GID} scripts/array.ipynb work/array.ipynb

# RUN jupyter lab workspaces import jupyterlab-workspace.json

# RUN echo 'c.ServerProxy.host_allowlist = ["localhost", "127.0.0.1", "dask-scheduler"]' >> /home/jovyan/.jupyter/jupyter_notebook_config.py

FROM ${BUILD_STAGE} AS final

USER ${NB_UID}
