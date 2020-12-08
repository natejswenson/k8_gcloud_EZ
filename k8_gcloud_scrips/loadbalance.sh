#!/bin/bash
{
  KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe k8-ez \
    --region $(gcloud config get-value compute/region) \
    --format 'value(address)')

  gcloud compute http-health-checks create kubernetes \
    --description "Kubernetes Health Check" \
    --host "kubernetes.default.svc.cluster.local" \
    --request-path "/healthz"

  gcloud compute firewall-rules create k8-ez-allow-health-check \
    --network k8-ez \
    --source-ranges 209.85.152.0/22,209.85.204.0/22,35.191.0.0/16 \
    --allow tcp

  gcloud compute target-pools create kubernetes-target-pool \
    --http-health-check kubernetes

  gcloud compute target-pools add-instances kubernetes-target-pool \
   --instances controller-0,controller-1,controller-2

gcloud compute forwarding-rules create kubernetes-forwarding-rule \
    --address ${KUBERNETES_PUBLIC_ADDRESS} \
    --ports 3000 \
    --region $(gcloud config get-value compute/region) \
    --target-pool kubernetes-target-pool
    
  gcloud compute forwarding-rules create kubernetes-forwarding-rule \
    --address ${KUBERNETES_PUBLIC_ADDRESS} \
    --ports 6443 \
    --region $(gcloud config get-value compute/region) \
    --target-pool kubernetes-target-pool
}
KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe k8-ez \
  --region $(gcloud config get-value compute/region) \
  --format 'value(address)')
  echo $blue Retrieve the k8-ez static IP address: $white
  echo ${KUBERNETES_PUBLIC_ADDRESS}
  echo $green Make a HTTP request the Kubernetes version info: $white
  curl --cacert ca.pem https://${KUBERNETES_PUBLIC_ADDRESS}:6443/version