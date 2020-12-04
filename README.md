# k8_gcloud_EZ
## Credit
This was creating using code and documentation providing in [kuberernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way)
## Purpuse
First I highly reccomend going through [kuberernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way) before you use this. That said i created this so I coud easily spin up a kube cluser and focus on learning/optimizing specific pieces.
## Prerequisites
This code assumes you have a GCP account and have the client tools installed on your machine. If you do not; fear not there are well documented by [Kelsey Hightower](https://github.com/kelseyhightower)


[prerequisites](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/01-prerequisites.md)

[client tools](https://github.com/kelseyhightower/kubernetes-the-hard-way/blob/master/docs/02-client-tools.md)

## Running
```sh
git clone https://github.com/natejswenson/k8_gcloud_EZ.git
cd k8_gcloud_EZ
./index.sh 
```
If this runns successfully you will have created:
```
NAME          ZONE        MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP     STATUS
controller-0  us-west1-c  e2-standard-2               10.240.0.10  x.x.x.x.x       RUNNING
controller-1  us-west1-c  e2-standard-2               10.240.0.11  x.x.x.x.x       RUNNING
controller-2  us-west1-c  e2-standard-2               10.240.0.12  x.x.x.x.x       RUNNING
worker-0      us-west1-c  e2-standard-2               10.240.0.20  34.83.74.23     RUNNING
worker-1      us-west1-c  e2-standard-2               10.240.0.21  x.x.x.x.x       STAGING
```

## Cleanup
`./cleanup.sh `
