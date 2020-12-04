#!/bin/bash
# Remove controller and workers
echo Delete the controller and worker compute instances:
gcloud -q compute instances delete \
  controller-0 controller-1 controller-2 \
  worker-0 worker-1 worker-2 \
  --zone $(gcloud config get-value compute/zone)

#Delet Networking
echo Delete the external load balancer network resources:
{
  gcloud -q compute forwarding-rules delete kubernetes-forwarding-rule \
    --region $(gcloud config get-value compute/region)

  gcloud -q compute target-pools delete kubernetes-target-pool

  gcloud -q compute http-health-checks delete kubernetes

  gcloud -q compute addresses delete k8_glcloud_EZ
}

#Delete firewall rules
echo Delete the k8_glcloud_EZ firewall rules:
gcloud -q compute firewall-rules delete \
  k8-ez-allow-nginx-service \
  k8-ez-allow-internal \
  k8-ez-allow-external \
  k8-ez-allow-health-check

#Delete network vpc
echo Delete the k8_glcloud_EZ network VPC:
{
  gcloud -q compute routes delete \
    kubernetes-route-10-200-0-0-24 \
    kubernetes-route-10-200-1-0-24 \
    kubernetes-route-10-200-2-0-24

  gcloud -q compute networks subnets delete kubernetes

  gcloud -q compute networks delete k8-ez
}
find . -type f -iname \*.pem -delete
find . -type f -iname \*.json -delete
find . -type f -iname \*.csr -delete
find . -type f -iname \*.yaml -delete
find . -type f -iname \*.kubeconfig -delete
