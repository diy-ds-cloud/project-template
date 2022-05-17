FROM jupyter/minimal-notebook:44fe185f9495

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}/work
USER root
RUN chown -R ${NB_UID} ${HOME}/work
USER ${NB_USER}

RUN pip install --no-cache-dir https://github.com/cookiecutter/cookiecutter/archive/refs/tags/2.0.2.tar.gz

RUN jupyter lab workspace import ${HOME}/work/binder/jupyterlab.workspace
