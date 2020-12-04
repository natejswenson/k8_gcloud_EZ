#!/bin/bash
echo Provisioning Compute Resources
echo Creating Virtual Private Cloud Network
#Create Virtual Private Cloud Netsork
gcloud compute networks create k8-ez --subnet-mode custom

gcloud compute networks subnets create kubernetes \
  --network k8-ez \
  --range 10.240.0.0/24

echo Creating Firewall Rules
#Create a firewall ru-le that allows internal communication across all protocols:
gcloud compute firewall-rules create k8-ez-allow-internal \
--allow tcp,udp,icmp \
--network k8-ez \
--source-ranges 10.240.0.0/24,10.200.0.0/16
#Create a firewall rule that allows external SSH, ICMP, and HTTPS
gcloud compute firewall-rules create k8-ez-allow-external \
--allow tcp:22,tcp:6443,icmp \
--network k8-ez \
--source-ranges 0.0.0.0/0

echo You have created the following firewall rules
gcloud compute firewall-rules list --filter="network:k8-ez"

#Set (Allocate) Public IP Address
echo Allocating static IP address
gcloud compute addresses create k8-ez \
--region $(gcloud config get-value compute/region)

echo your Public IP address is:
gcloud compute addresses list --filter="name=('k8-ez')"

#Setting up Compute Instances
for i in 0 1 2; do
  echo working on creating controller-${i}
  gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2004-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-2 \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags k8-ez,controller
done

#Setting up k8 workers
for i in 0 1 2; do
  echo working on creating worker-${i}
  gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2004-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-2 \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet kubernetes \
    --tags k8-ez,worker
 #verification
 echo the following resources have been created:
gcloud compute instances list --filter="tags.items=k8-ez"
done

return 0
