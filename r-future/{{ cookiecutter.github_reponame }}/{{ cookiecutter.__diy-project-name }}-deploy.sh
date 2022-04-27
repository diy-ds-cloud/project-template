#!/bin/bash

# USER_ID="syoh@ucsb.edu"
# PROJECT_ID="testing-sandbox-324502"
# REGION_CODE="us-central1-a"
# HELM_CHART_VERSION="0.0.1-n002.h282189f"

set -e

DIY_CONFIG_DIR="${HOME}/.config/{{ cookiecutter.__diy-project-name }}"
DIY_CONFIG_FILE="${DIY_CONFIG_DIR}/config.sh"

if [[ -f $DIY_CONFIG_FILE ]]; then
    source $DIY_CONFIG_FILE
else
    echo "Run {{ cookiecutter.__diy-project-name }}-setup.sh first before running this script"
    exit 1
fi

echo "--------------------------------------------"
echo "DIY Cloud Computing for Data Science using R"
echo "--------------------------------------------"

echo -e "\n\n## Creating cluster under project, ${PROJECT_ID} in region, ${ZONE_CODE}"
terraform -chdir=cluster init
terraform -chdir=cluster apply -var="project_id=${PROJECT_ID}" -var="region=${ZONE_CODE}" -auto-approve

CLUSTER_NAME=$(terraform -chdir=cluster output -raw kubernetes_cluster_name)
gcloud container clusters get-credentials ${CLUSTER_NAME} --zone=${ZONE_CODE} --project=${PROJECT_ID}

echo -e "\n\n## Deploying Rstudio application with Helm chart version, ${HELM_CHART_VERSION}"
helm repo add {{ cookiecutter.github_reponame }} https://{{ cookiecutter.github_orgname }}.github.io/{{ cookiecutter.github_reponame }}
helm repo update
helm install myrelease {{ cookiecutter.github_reponame }}/{{ cookiecutter.__diy-project-name }} --version "${HELM_CHART_VERSION}" --wait

{% raw %}
SERVICE_IP=$(kubectl get svc myrelease-{{ cookiecutter.__diy-project-name }}-notebook --namespace default --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
{% endraw %}
echo "\n\n## Rstudio is available at URL: http://$SERVICE_IP:80"
