#!/bin/bash
echo $blue enerate a kubeconfig file suitable for authenticating as the admin user: $white
{
  KUBERNETES_PUBLIC_ADDRESS=$(gcloud compute addresses describe k8-ez \
    --region $(gcloud config get-value compute/region) \
    --format 'value(address)')

  kubectl config set-cluster k8-ez \
    --certificate-authority=ca.pem \
    --embed-certs=true \
    --server=https://${KUBERNETES_PUBLIC_ADDRESS}:6443

  kubectl config set-credentials admin \
    --client-certificate=admin.pem \
    --client-key=admin-key.pem

  kubectl config set-context k8-ez \
    --cluster=k8-ez \
    --user=admin

  kubectl config use-context k8-ez
}
echo $blue Check the health of the remote Kubernetes cluster: $white
kubectl get componentstatuses

echo $blueList the nodes in the remote Kubernetes cluster: $white
kubectl get nodes

return 0