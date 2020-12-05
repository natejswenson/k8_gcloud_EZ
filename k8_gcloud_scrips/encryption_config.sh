#!/bin/bash
#Encryption Config File
echo $red creating the encyption-config.yaml encyption File $white

ENCRYPTION_KEY=$(head -c 32 /dev/urandom | base64)

cat > encryption-config.yaml <<EOF
kind: EncryptionConfig
apiVersion: v1
resources:
  - resources:
      - secrets
    providers:
      - aescbc:
          keys:
            - name: key1
              secret: ${ENCRYPTION_KEY}
      - identity: {}
EOF

for instance in controller-0 controller-1 controller-2; do
    echo $green copy files to ${instance} $white
    gcloud compute scp encryption-config.yaml ${instance}:~/
    gcloud compute scp ~/k8/k8scrips/k8_gcloud_scrips/k8bs.sh ${instance}:~/
    gcloud compute scp ~/k8/k8scrips/k8_gcloud_scrips/controlplan.sh ${instance}:~/
done
echo $green copy rbac.sh to controller-0: $white
gcloud  compute scp ~/k8/k8scrips/k8_gcloud_scrips/rbac.sh controller-0:~/
return 0
 