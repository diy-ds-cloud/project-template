#!/bin/bash

TEMP=$(getopt -o r:p:n:s: --long run-mode:,port:,n-workers:,scheduler: \
              -n "$0" -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

eval set -- "$TEMP"

while true ; do

    case "$1" in
        -r|--run-mode) 
            RUN_MODE="$2"
            echo "Option RUN_MODE, argument '$RUN_MODE'" 
            shift 2
            ;;
        -s|--scheduler)
            SCHEDULER="$2"
            echo "Option SCHEDULER, argument '$SCHEDULER'" 
            shift 2
            ;;
        -p|--port)
            PORT="$2"
            echo "Option PORT, argument '$PORT'" 
            shift 2
            ;;
        -n|--n-workers)
            NWORKERS="$2"
            echo "Option NWORKERS, argument '$NWORKERS'" 
            shift 2
            ;;
        --) 
            shift
            break
            ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac

done

# set scheduler port for workers to connect to
if [ "$RUN_MODE" == "scheduler" ]
then
    echo R_PARALLEL_PORT=${PORT} >> /opt/conda/lib/R/etc/Renviron
    echo NSLOTS=${NWORKERS}      >> /opt/conda/lib/R/etc/Renviron
fi

# specify scheduler name/ip address and port to workers
if [ "$RUN_MODE" == "worker" ]
then
    echo "# starting workers"

    while true
    do

        Rscript --default-packages=datasets,utils,grDevices,graphics,stats,methods \
            -e 'workRSOCK <- tryCatch(parallel:::.workRSOCK, error=function(e) parallel:::.slaveRSOCK); workRSOCK()' \
            MASTER=${SCHEDULER} \
            PORT=${PORT} \
            OUT=/tmp/rworker.log \
            SETUPTIMEOUT=2592000 \
            TIMEOUT=2592000 \
            XDR=TRUE || true

        echo "# restarting workers"

    done
fi