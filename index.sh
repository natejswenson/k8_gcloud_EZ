#!/bin/bash
# Provisioning Compute Resources

sh ./k8_gcloud_scrips/compute_resources.sh 
sh ./k8_gcloud_scrips/certificate_authority.sh 
sh ./k8_gcloud_scrips/k8_configfiles.sh 
sh ./k8_gcloud_scrips/encryption_config.sh 
sh ./k8_gcloud_scrips/bs.sh 

exit 