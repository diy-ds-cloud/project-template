# Do-it-yourself Cloud Computing for Data Science Project Templates

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/diy-ds-cloud/project-template/HEAD)

**Important**: This repository contains [cookicutter templates](https://github.com/cookiecutter/cookiecutter#readme) that require [other software]() to generate properly.

To start, click on the badge above and follow rest of the steps in the Binder session.

## Quickstart

**Prerequisites**: Cookiecutter templates in this repository requires [GitHub](https://github.com) and [Docker Hub](https://hub.docker.com) accounts.

When instantiating the template, Cookiecutter will ask you to supply the following information:

1. Project name
1. Project description
1. GitHub user name
1. GitHub organization name (defaults to GitHub username)
1. GitHub repository name
1. Docker Hub username
1. Docker Hub organization name (defaults to Docker username)

After the Binder session has started, execute the following command in the terminal:
```bash
cookiecutter 
```

## Technical details

The cookiecutter repository will perform the following steps:

1. Collect information about your data science project such as project name, description, GitHub username, Docker Hub username, etc.
1. Generate a set of customized files to deploy distributed computing infrastructure. 
1. Create a GitHub repository, commit, and push the generated files
1. Create GitHub secrets necessary for pushing Docker images to Docker Hub
1. Create GitHub pages branch to publish the custom Helm chart
1. Create GitHub actions to build/push Docker images to Docker Hub and generate/publish a new Helm chart version to GitHub pages