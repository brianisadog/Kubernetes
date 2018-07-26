## Setup Terraform environment on your main machine

    ```shell
    cd Terraform-Kubernetes/
    ./terraform-setup.sh
    ```

## Edit the configuration file

    ```shell
    nano var.tf  # direct to one of your master nodes
    ```

## Initialize Terraform-Kubernetes-Provider and deploy your application

- Must use plugin to initialize

    ```shell
    terraform init -plugin-dir=$HOME/go/bin
    terraform plan
    terraform apply
    ```

- Now you can access your application with the external_ip and target_port set in **bootcamp.tf**

    ```shell
    while true; do curl <external_ip>:<target_port>; sleep .5; done
    # or just use browser to access it
    ```

## Add another deployment into cluster

- Use namespace to separate different deployments in order to deploy different applications on same cluster
- Simply add one ".tf" file and specify the namespace, deployment, and service
- You can take a look at **bootcamp.tf** example
