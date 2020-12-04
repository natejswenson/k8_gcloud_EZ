#!/bin/bash
for instance in controller-0 controller-1 controller-2; do
    echo bootstrapping ${instance} 
    gcloud compute ssh ${instance} --command="./k8bs.sh "
done

return 0