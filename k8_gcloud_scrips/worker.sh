#!/bin/bash
for instance in worker-0 worker-1 worker-2; do
    echo $red bootsrapping kubernetes worker: $blue ${instance} $white
    gcloud compute ssh ${instance} --command="./workernode.sh "
return 0