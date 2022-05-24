# {{ cookiecutter.project_name }}

{{ cookiecutter.project_description }}

## Quick-start Instructions

The scripts in this repository make it simplt to start a cluster of computers to run the analysis code for this project.

The instructions below will guide you in creating a Kubernetes cluster on Google Cloud Platform with your credentials.

### Step 1: Prerequisites

This project will help you create a [Kubernetes cluster](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/) on [Google Cloud Platform](https://cloud.google.com), and the following are required to deploy and run the scripts in this repository:

1. [Google Cloud account](https://cloud.google.com)
1. [Google Cloud project id](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
1. [gcloud CLI](https://cloud.google.com/sdk/docs/install) installed on your local computer with a web browser. This is a necessary step for login in Step 2.

### Step 2: Setup and deploy cluster

1. [Binder](https://mybinder.org) can start a customized computing environment in the browser with software requirements pre-installed.  
    Start a Binder session by clicking on the badge:  
    [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/{{ cookiecutter.github_orgname }}/{{ cookiecutter.github_reponame }}/main?urlpath=git-pull%3Frepo%3Dhttps%253A%252F%252Fgithub.com%252F{{ cookiecutter.github_orgname }}%252F{{ cookiecutter.github_reponame }}%26urlpath%3Dlab%252Ftree%252F{{ cookiecutter.github_reponame }}%252F%26branch%3Dmain)
1. With `docker` and `docker-compose` available, start dev container:
    ```bash
    docker-compose build jupyterlab
    docker-compose up
    ```
1. Start a [terminal session in Jupyter Lab](https://jupyterlab.readthedocs.io/en/stable/user/terminal.html) and `cd` into directory `{{ cookiecutter.github_reponame }}`
    ```bash
    cd ~/{{ cookiecutter.github_reponame }}
    ```
3. In a terminal prompt, execute  
    ```bash
    ./{{ cookiecutter.__diy_project_name}} config
    ```
    This command logs you into your Google Cloud account, sets project id, compute zone, and Helm chart version choices for running the analysis application in this repository.
1. Subsequently, execute 
    ```bash
    ./{{ cookiecutter.__diy_project_name}} deploy
    ```

### Step 3: Open and start interface session (Jupyter notebook or RStudio)
1. Find and open a URL on the last line of `{{ cookiecutter.__diy_project_name}} deploy` command. Something like,
    ```bash
    Interface is available at URL: http://[some-ip-address]:80
    ```
1. Login using default password: `diy-cloud`

## Technical details

### Do-it-yourself Cloud Computing Files

```
├── application
│   ├── chartpress.yaml
│   ├── {{ cookiecutter.__diy_project_name }}
│   │   ├── Chart.yaml
│   │   ├── templates
│   │   │   ├── _helpers.tpl
│   │   │   ├── notebook-deployment.yaml
│   │   │   ├── notebook-service.yaml
│   │   │   ├── NOTES.txt
│   │   │   └── worker-deployment.yaml
│   │   └── values.yaml
│   ├── docker-images
│   │   ├── docker-compose.yml
│   │   ├── Dockerfile
│   │   ├── etc
│   │   │   └── future-vars.sh
│   │   ├── README.md
│   │   └── scripts
│   │       └── startup.R
│   └── scripts
│       ├── chartpress-common.sh
│       └── chartpress-publish.sh
├── binder
│   └── new-workspace.jupyterlab-workspace
├── cluster
│   ├── gke.tf
│   ├── kubernetes-dashboard-admin.rbac.yaml
│   ├── outputs.tf
│   ├── README.md
│   └── versions.tf
├── {{ cookiecutter.__diy_project_name }}
├── README.md
└── script.R
```
### `application` directory

`application` directory contains the necessary information to build and deploy the _application_ (RStudio and [future](https://future.futureverse.org) installation image and configuration) for running the analysis code.

1. `{{ cookiecutter.__diy_project_name }}` directory defines a [Helm chart](https://helm.sh) for this project. `Chart.yaml` defines the chart, and `templates` directory defines various computational components (RStudio controller node vs. R worker node) for the cluster. `templates` directory also specifies how the components are connected as controller and worker nodes. Think of machines and how they are interconnected to carry out distributed computation.
1. `docker-images` directory contains [docker images](https://docs.docker.com/get-started/overview/#images) of RStudio node and R worker nodes. `future-vars.sh` is a script that defines controller and worker settings. `Dockerfiles` can be modified to add custom packages or libraries
1. `chartpress.yaml` file and `scripts` directory contain information needed for [`chartpress`](https://github.com/jupyterhub/chartpress). Chartpress does the following:  
    a. Compile a Helm chart and Docker images with [Github actions](https://github.com/{{ cookiecutter.github_orgname }}/{{ cookiecutter.github_reponame }}/actions)  
    b. Update the [project repository page](https://{{ cookiecutter.github_orgname }}.github.io/{{ cookiecutter.github_reponame }})  
    c. Upload compiled Docker images with to [Docker hub](https://hub.docker.com/u/{{ cookiecutter.docker_orgname }})

_Reference: [`jupyterhub/chartpress` README.md page](https://github.com/jupyterhub/chartpress#readme)_, [How to create a Helm chart repository with Chartpress, Travis CI, GitHub Pages and Jekyll (outdated)](https://jacobtomlinson.dev/posts/2019/how-to-create-a-helm-chart-repository-with-chartpress-travis-ci-github-pages-and-jekyll/)

### `cluster` directory

`cluster` directory contains infrastructure-as-code code in terraform format.

1. `gke.tf` defines infrastructure information such as the number of nodes in Kubernetes cluster, the Google Cloud compute zone to create the cluster in, the network service to start (or internet access).

_Reference: [Manage Kubernetes Resources via Terraform](https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider)_

### `{{ cookiecutter.__diy_project_name }}` script

`{{ cookiecutter.__diy_project_name }}` script coordinates the configuration and deployment of infrastructure on the cloud with the above functionalities.

1. `{{ cookiecutter.__diy_project_name }} config` command saves Google cloud account, project id, compute zone as well as Helm chart version to use in deployment.
1. `{{ cookiecutter.__diy_project_name }} deploy` command executes terraform and helm commands to deploy Kubernetes cluster and populates "pods".
