# cks-terraform

> Simple terraform script to provision 2 node k8s cluster for killer.sh CKS environment

## Usage:
Clone this repo and `cd` into it

1. Login to gcloud and set a default project:
    ```sh
    gcloud auth login
    gcloud auth application-default login
    gcloud config set project $PROJECT_NAME
    ```

1. Init terraform:
    ```sh
    tf init
    ```

1. Set project variable in terraform:
    ```sh
    export TF_VAR_project_name=$(gcloud config get project)
    ```

1. Plan and Apply changes:
    ```sh
    tf apply -auto-approve
    ```

1. Login to cks-master node (GCP) and check status of nodes:
    ```sh
    gcloud compute ssh root@cks-master --command="kubectl get nodes -o wide"
    ```

## Extra Components:

In case you wanna add some other components to existing cluster.


1. Install OPA (Open Policy Agent)
    ```sh
    # run on master node
    gcloud compute ssh root@cks-master --command="kubectl create -f https://raw.githubusercontent.com/killer-sh/cks-course-environment/master/course-content/opa/gatekeeper.yaml"
    ```




## TODO
- [ ] Migrate from `local-exec` to use ansible playbook