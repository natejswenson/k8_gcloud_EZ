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
sh ./k8_gcloud_scrips/worker.sh 
sh ./k8_gcloud_scrips/admin.sh 
sh ./k8_gcloud_scrips/networkpod_routes.sh 
sh ./k8_gcloud_scrips/dns.sh 
exit 