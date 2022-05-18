#!/bin/bash

# jupyter labextension install dask-labextension

# /proxy/dask-scheduler:8787/status
# DASK_DASHBOARD_HOST=$(sed 's/:.*//' <<< "dask-scheduler:8787")
DASK_DASHBOARD_HOST=$(sed 's/:.*//' <<< "${DASK_DASHBOARD_ADDRESS}")
echo "################### $DASK_DASHBOARD_HOST"

# add dashboard host to jupyter-server-proxy allowlist
# echo 'c.ServerProxy.host_allowlist = ["localhost", "127.0.0.1", "dask-scheduler"]' >> /home/jovyan/.jupyter/jupyter_notebook_config.py
echo "c.ServerProxy.host_allowlist = ['localhost', '127.0.0.1', '${DASK_DASHBOARD_HOST}']" >> /home/jovyan/.jupyter/jupyter_notebook_config.py

# setup workspace address
sed -i -e "s|DASK_DASHBOARD_URL|http://127.0.0.1:8888/proxy/${DASK_DASHBOARD_ADDRESS}|g" /home/jovyan/jupyterlab-workspace.json
# sed -i -e "s|DASK_DASHBOARD_URL|/proxy/${DASK_DASHBOARD_ADDRESS}/status|g" /home/jovyan/jupyterlab-workspace.json
jupyter lab workspaces import /home/jovyan/jupyterlab-workspace.json