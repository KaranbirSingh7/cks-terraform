# cks-terraform

> Simple terraform script to provision 2 node k8s cluster for killer.sh CKS environment

## Usage:
Clone this repo and `cd` into it

1. Login to gcloud:
    ```sh
    gcloud auth application-default login
    ```

1. Init terraform:
    ```sh
    tf init
    ```

1. Plan and Apply changes:
    ```sh
    tf apply -auto-approve
    ```

1. Login to cks-master node (GCP) and check status of nodes:
    ```sh
    gcloud compute ssh root@cks-master --command="kubectl get nodes -o wide"
    ```




## TODO
- [ ] Migrate from `local-exec` to use ansible playbook