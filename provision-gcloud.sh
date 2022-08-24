#!/bin/bash
set -euo pipefail

region=us-central1-a

# CREATE cks-master VM using gcloud command
# not necessary if created using the browser interface
gcloud compute instances create cks-master --zone=$region \
    --machine-type=e2-medium \
    --image=ubuntu-2004-focal-v20220419 \
    --image-project=ubuntu-os-cloud \
    --boot-disk-size=50GB

# CREATE cks-worker VM using gcloud command
# not necessary if created using the browser interface
gcloud compute instances create cks-worker --zone=$region \
    --machine-type=e2-medium \
    --image=ubuntu-2004-focal-v20220419 \
    --image-project=ubuntu-os-cloud \
    --boot-disk-size=50GB

# INSTALL cks-master
# gcloud compute ssh cks-master
# sudo -i
# bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_master.sh)

# # INSTALL cks-worker
# gcloud compute ssh cks-worker
# sudo -i
# bash <(curl -s https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/cluster-setup/latest/install_worker.sh)
