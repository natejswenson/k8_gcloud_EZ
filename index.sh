#!/bin/bash
# Provisioning Compute Resources
export red=$'\e[1;31m'
export green=$'\e[1;32m'
export blue=$'\e[1;34m'
export white=$'\e[0m'

sh ./k8_gcloud_scrips/compute_resources.sh 
sh ./k8_gcloud_scrips/certificate_authority.sh 
sh ./k8_gcloud_scrips/k8_configfiles.sh 
sh ./k8_gcloud_scrips/encryption_config.sh 
sh ./k8_gcloud_scrips/bs.sh 
sh ./k8_gcloud_scrips/loadbalance.sh 
for instance in controller-0 controller-1 controller-2; do
    echo $red bootsrapping kubernetes worker: ${instance} $white
    gcloud compute ssh ${instance} --command="./k8_gcloud_scrips/workernode.sh "
done



exit 