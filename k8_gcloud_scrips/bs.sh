#!/bin/bash
for instance in controller-0 controller-1 controller-2; do
    echo $red bootstrapping etcd on: ${instance} $white
    gcloud compute ssh ${instance} --command="./k8bs.sh "
done
for instance in controller-0 controller-1 controller-2; do
    echo $red bootsrapping conrol plan on: ${instance} $white
    gcloud compute ssh ${instance} --command="./controlplan.sh "
done
echo $red Configure RBAC permissions on controller-0 $white
gcloud compute ssh controller-0 --command="./rbac.sh "


return 0