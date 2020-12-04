#!/bin/bash
#Encryption Config File
echo creating the encyption-config.yaml encyption File

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
    echo copy the encyption-config.yaml to ${instance}
    gcloud compute scp encryption-config.yaml ${instance}:~/
    echo copy the bootstrap.sh to ${instance}
    gcloud compute scp ~/k8/k8scrips/k8_gcloud_scrips/k8bs.sh ${instance}:~/
done

return 0
 