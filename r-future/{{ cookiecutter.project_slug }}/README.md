[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/{{ cookiecutter.github_orgname }}/{{ cookiecutter.github_reponame }}/main?urlpath=git-pull%3Frepo%3Dhttps%253A%252F%252Fgithub.com%252F{{ cookiecutter.github_orgname }}%252F{{ cookiecutter.project_reponame }}%26urlpath%3Dlab%252Ftree%252Fr-future%252F%26branch%3Dmain)

```bash
USER_ID="syoh@ucsb.edu"
PROJECT_ID="testing-sandbox-324502"
REGION_CODE="us-central1-a"
HELM_CHART_VERSION="0.0.2-n009.hcb36596"

echo "Creating Kubernetes cluster"

echo "Step 1: logging in as user, ${USER_ID}"
gcloud auth login "${USER_ID}" --no-browser --update-adc

echo "Step 2: creating cluster under project, ${PROJECT_ID} in region, ${REGION_CODE}"
terraform -chdir=r-future/cluster init
terraform -chdir=r-future/cluster apply -var="project_id=${PROJECT_ID}" -var="region=${REGION_CODE}" -auto-approve

CLUSTER_NAME=$(terraform -chdir=r-future/cluster output -raw kubernetes_cluster_name)
gcloud container clusters get-credentials ${CLUSTER_NAME} --zone=${REGION_CODE} --project=${PROJECT_ID}

echo "Step 3: deploying Rstudio application with Helm chart version, ${HELM_CHART_VERSION}"
helm repo add r-future https://diy-ds-cloud.github.io/r-future
helm repo update
helm install myrelease r-future/diy-r-future --version "${HELM_CHART_VERSION}" --wait
{% raw %}
SERVICE_IP=$(kubectl get svc myrelease-diy-r-future-notebook --namespace default --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
{% endraw %}
echo "Rstudio is available at URL: http://$SERVICE_IP:80"
```
https://cloud.google.com/docs/terraform