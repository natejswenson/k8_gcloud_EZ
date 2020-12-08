echo $blue Print the internal IP address and Pod CIDR range for each worker instance: $white

for instance in worker-0 worker-1 worker-2; do
  gcloud compute instances describe ${instance} \
    --format 'value[separator=" "](networkInterfaces[0].networkIP,metadata.items[0].value)'
done

echo $blue Create network routes for each worker instance: $white

for i in 0 1 2; do
  gcloud compute routes create kubernetes-route-10-200-${i}-0-24 \
    --network k8-ez \
    --next-hop-address 10.240.0.2${i} \
    --destination-range 10.200.${i}.0/24
done
echo $blue List the routes in the k8-ez VPC network: $white

gcloud compute routes list --filter "network: k8-ez"