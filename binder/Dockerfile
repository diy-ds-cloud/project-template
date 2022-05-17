FROM jupyter/minimal-notebook:aa14e4498c6b

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

RUN pip install --no-cache-dir https://github.com/cookiecutter/cookiecutter/archive/refs/tags/2.0.2.tar.gz
