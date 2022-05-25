# Do-it-yourself Cloud Computing for Data Science Project Templates

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/diy-ds-cloud/project-template/HEAD)

**Important**: This repository contains [cookicutter templates](https://github.com/cookiecutter/cookiecutter#readme) that require [other software](https://github.com/diy-ds-cloud/project-template#software-prerequisites) to generate.

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

### Step 3: Choose user interface

### Step 3.1: Binder session

Start a Binder session by clicking on the badge above

### Step 3.2: `docker` and `docker-compose` (advanced)
If you have docker and docker-compose that can run Ubuntu container images, starting your own Jupyter lab session is another possibility.

```bash
(
    cd project-template
    docker-compose build jupyterlab
    docker-compose up
)
```

### Step 3: Generate files for your project

Then, execute the following command in the Jupyter Lab terminal and follow the prompt.

|                  | Python                     | R                       |
|------------------|----------------------------|-------------------------|
| Command          | `cookiecutter project-template --directory=python-dask` | `cookiecutter project-template --directory=r-future` |

When the process completes, all generated files have been uploaded to the newly created GitHub repository. At the end of generation, you should get a message similar to the following:

```
## Step 7: relevant links
## GitHub repository: https://github.com/diy-ds-cloud/my-ds-project
## Helm Chart GitHub page: https://diy-ds-cloud.github.io/my-ds-project
## Docker images: https://hub.docker.com/u/dddlab
```

When GitHub action shows successful completion, these links are to the artifacts your project repository generated. This process of building the Helm chart and Docker images will automatically run after every commit.

In your Binder session, generated files are located in the home directory. If my repository name is `my-ds-project`, the directory would be at `/home/jovyan/my-ds-project`. 

You are free to close your Binder session if you wish.

### Step 4: Customize your project's files

Now, you can step over to your project's README file to deploy your infrastructure!

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

Shield: [![CC BY-SA 4.0][cc-by-sa-shield]][cc-by-sa]

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
[cc-by-sa-shield]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg
