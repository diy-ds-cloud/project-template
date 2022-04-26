#!/bin/bash

DIY_CONFIG_DIR="${HOME}/.config/diy-{{ cookiecutter.github_reponame }}"
DIY_CONFIG_FILE="${DIY_CONFIG_DIR}/config.sh"

TEMP=$(getopt -o f:: --long force:: \
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

if [[ ! -d $DIY_CONFIG_DIR ]]; then
    echo "dir doesn't exist"
    mkdir -p $DIY_CONFIG_DIR
fi

if [[ -f $DIY_CONFIG_FILE ]]; then
    if [ $FORCE = true ]; then
        rm $DIY_CONFIG_FILE
    else
        echo "Previous configuration exists: ${DIY_CONFIG_FILE}"
        echo "Exiting"
        exit 1
    fi
fi

# echo "What is your GitHub ID?"
echo "What is your Google Cloud username?"

# USER_ID="syoh@ucsb.edu"
# PROJECT_ID="testing-sandbox-324502"
# REGION_CODE="us-central1-a"
# HELM_CHART_VERSION="0.0.1-n002.h282189f"
