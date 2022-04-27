#!/bin/bash

set -e

DIY_CONFIG_DIR="${HOME}/.config/{{ cookiecutter.__diy_project_name }}"
DIY_CONFIG_FILE="${DIY_CONFIG_DIR}/config.sh"

TEMP=$(getopt -o f --long force \
              -n 'diy-setup.sh' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around '$TEMP': they are essential!
eval set -- "$TEMP"

while true ; do
    case "$1" in
        -f|--force-init)
            FORCE=true; 
            shift ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

function login() {
    echo -e "\n\n## Login to Google Cloud"
    gcloud auth login --no-browser --update-adc
}

function read_config() {
    echo -e "\n\n## Choose an existing project ID in which to create the cluster"
    gcloud projects list
    printf "  Copy/paste a PROJECT_ID from the list above: "
    read PROJECT_ID

    echo -e "\n\n## Choose a region and zone in which to create the cluster"
    gcloud compute zones list
    printf "  Copy/paste a NAME from the list above: "
    read ZONE_CODE

    echo -e "\n\n## Choose an application version to install in the cluster from this URL"
    echo -e "  https://{{ cookiecutter.github_orgname }}.github.io/{{ cookiecutter.github_reponame }}"
    printf "  Copy/paste a Chart Version the URL above: "
    read HELM_CHART_VERSION
}

function source_config() {
    source $DIY_CONFIG_FILE
}

function write_config() {
    echo "PROJECT_ID=$PROJECT_ID" >> $DIY_CONFIG_FILE
    echo "ZONE_CODE=$ZONE_CODE" >> $DIY_CONFIG_FILE
    echo "HELM_CHART_VERSION=$HELM_CHART_VERSION" >> $DIY_CONFIG_FILE
}

function apply_config() {
    gcloud config set core/project "$PROJECT_ID"
    gcloud config set compute/zone "$ZONE_CODE"
}

if [[ ! -d $DIY_CONFIG_DIR ]]; then
    echo "dir doesn't exist"
    mkdir -p $DIY_CONFIG_DIR
fi

# delete any existing file if being forced
if [ "$FORCE" = true ]; then
    rm -f $DIY_CONFIG_FILE
fi

if [[ -f $DIY_CONFIG_FILE ]]; then
    source_config
    login
    apply_config
else
    login
    read_config
    apply_config
    write_config
fi