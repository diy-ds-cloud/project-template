# Do-it-yourself Cloud Computing for Data Science Project Templates

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/diy-ds-cloud/project-template/HEAD)

**Important**: This repository contains [cookicutter templates](https://github.com/cookiecutter/cookiecutter#readme) that require [other software]() to generate properly.

To start, click on the badge above and follow rest of the steps in the Binder session.

## Quickstart

### Step 1: Project information and repository settings

**Prerequisites**: Cookiecutter templates in this repository requires [GitHub](https://github.com) and [Docker Hub](https://hub.docker.com) accounts.

When instantiating the template, Cookiecutter will ask you to supply the following information:

1. Project name
1. Project description
1. GitHub user name, organization name (defaults to user name), repository name
1. Docker Hub username, organization name (defaults to user name)

### Step 2: Choosing your language: Python or R

This repository contains templates for creating projects in Python or R. Distributed computing is accomplished by starting a Kubernetes cluster on Google Cloud, then populating the "pods" with suitable Docker images for scheduler and workers.

|                  | Python                                          | R                          	           |
|------------------|-------------------------------------------------|-----------------------------------------|
| Parallel library | [Dask](https://dask.org)                        | [Future](https://future.futureverse.org)|
| User interface   | [Jupyter Lab](https://jupyter.org)              | [RStudio](https://www.rstudio.com)      |
| Deployed pods    | 1 x Jupyter Lab<br>1 x scheduler<br>2 x workers | 1 x RStudio<br>2 x workers 	           |

### Step 3: Generate files for your project

If you haven't already, start a Binder session by clicking on the badge above. Then, execute the following command in the Jupyter Lab terminal and follow the prompt.

|                  | Python                     | R                       |
|------------------|----------------------------|-------------------------|
| Command          | `cookiecutter python-dask` | `cookiecutter r-future` |

When the process completes, you should get a message similar to the following:
```

```

### Step 4: Inspect project repository

## Technical details

The cookiecutter repository will perform the following steps:

1. Collect information about your data science project such as project name, description, GitHub username, Docker Hub username, etc.
1. Generate a set of customized files to deploy distributed computing infrastructure. 
1. Create a GitHub repository, commit, and push the generated files
1. Create GitHub secrets necessary for pushing Docker images to Docker Hub
1. Create GitHub pages branch to publish the custom Helm chart
1. Create GitHub actions to build/push Docker images to Docker Hub and generate/publish a new Helm chart version to GitHub pages

### Software prerequisites

In order to perform the steps above, following software are required:

1. [GitHub command line interface](https://cli.github.com)
1. [Google Cloud command line interface](https://cloud.google.com/cli)
1. [Terraform command line interface](https://www.terraform.io/cli/commands)

These are installed in the [Dockerfile](binder/Dockerfile)