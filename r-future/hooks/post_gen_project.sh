#!/bin/bash

set -e

echo "--------------------------------------------"
echo "DIY Cloud Computing for Data Science using R"
echo "--------------------------------------------"

echo -e "\n\n## Step 1: login to GitHub"
gh auth login --git-protocol ssh --scopes workflow,delete_repo --hostname github.com

echo -e "\n\n## Step 2: create project repository: {{ cookiecutter.github_orgname }}/{{ cookiecutter.github_reponame }}"
# create/push empty repository before setting gh actions credentials
gh repo create --public {{ cookiecutter.github_orgname }}/{{ cookiecutter.github_reponame }}

git config --global 'credential.https://github.com.helper' ''
git config --global --add 'credential.https://github.com.helper' '!gh auth git-credential'

git init
git commit --allow-empty -m "empty commit"
git branch -M main
git remote add origin https://github.com/{{ cookiecutter.github_orgname }}/{{ cookiecutter.github_reponame }}.git
git push -u origin main

echo -e "\n\n## Step 3: set repository secrets"
# credentials for gh actions
gh secret set CHART_DEPLOY_KEY < /home/jovyan/.ssh/id_ed25519
gh secret set DOCKERHUB_USERNAME --body "{{ cookiecutter.docker_username }}"
echo -e "\n### Step 3.1: enter your Docker hub password"
gh secret set DOCKERHUB_PASSWORD

# finally commit main branch files
(
    cd binder
    ln -s ../.devcontainer/Dockerfile Dockerfile 
)
git add .
git commit -m "initial commit"

echo -e "\n\n## Step 4: create GitHub pages branch"
# create gh pages branch
git switch --orphan gh-pages

cat << EOF > Gemfile
source "https://rubygems.org"
gem "github-pages", group: :jekyll_plugins
EOF

cat << EOF > _config.yml
# This is a Jekyll configuration file
# ref: https://jekyllrb.com/docs/configuration/options/
#
# We make use of this theme, and it is what makes title and description have
# meaning.
# ref: https://github.com/pages-themes/minimal
# _config.yaml
title: DIY Cloud Computing with R
description: This helm chart deploys customized R future-based distributed computing platform on a Kubernetes cluster.
theme: minima
url: "https://{{ cookiecutter.github_orgname }}.github.io/{{ cookiecutter.github_reponame }}"
repo_name: {{ cookiecutter.github_reponame }}
exclude:
  - Gemfile
  - Gemfile.lock
  - .gitignore
EOF

{% raw %}
cat << EOF > index.md
---
layout: default
---

## Getting Started

{{ site.description }}

You can add this repository to your local helm configuration as follows :

\`\`\`console
$ helm repo add {{ site.repo_name }} {{ site.url }}
$ helm repo update
\`\`\`

## Charts

{% for helm_chart in site.data.index.entries %}
{% assign title = helm_chart[0] | capitalize %}
{% assign all_charts = helm_chart[1] | sort: 'created' | reverse %}
{% assign latest_chart = all_charts[0] %}

<h3>
  {% if latest_chart.icon %}
  <img src="{{ latest_chart.icon }}" style="height:1.2em;vertical-align: text-top;" />
  {% endif %}
  {{ title }}
</h3>

[Home]({{ latest_chart.home }}) \| [Source]({{ latest_chart.sources[0] }})

{{ latest_chart.description }}

\`\`\`console
$ helm install myrelease {{ site.repo_name }}/{{ latest_chart.name }} --version {{ latest_chart.version }} --wait
\`\`\`

| Chart | Chart Version | App Version | Date |
|-------|---------------|-------------|------|
{% for chart in all_charts -%}
| [{{ chart.name }}-{{ chart.version }}]({{ chart.urls[0] }}) | {{ chart.version }} | {{ chart.appVersion }} | {{ chart.created | date_to_rfc822 }} |
{% endfor -%}

{% endfor %}
EOF
{% endraw %}

(
    mkdir _data
    cd _data
    ln -s ../index.yaml
)

git add _data/ Gemfile _config.yml index.md
git commit -m'initial commit'
git push -u origin gh-pages

echo -e "\n\n## Step 5: push changes"
git checkout main
git push

echo -e "\n\n## Step 6: set project description"
gh repo edit --description "{{ cookiecutter.project_description }} https://{{ cookiecutter.github_orgname }}.github.io/{{ cookiecutter.github_reponame }}"

# gh workflow enable "Publish helm chart and docker images"
echo -e "\n\n## Step 7: relevant links"
echo -e "## GitHub repository: https://github.com/{{ cookiecutter.github_orgname }}/{{ cookiecutter.github_reponame }}"
echo -e "## Helm Chart GitHub page: https://{{ cookiecutter.github_orgname }}.github.io/{{ cookiecutter.github_reponame }}"
echo -e "## Docker images: https://hub.docker.com/u/{{ cookiecutter.docker_orgname }}"