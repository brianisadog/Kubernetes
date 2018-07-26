## Setup Kubernetes environment on **all** nodes

- Go to Kubernetes-Cluster directory
- Edit and run env_setup.sh first
- Run k8s-docker-setup.sh, k8s-docker-pull.sh and k8s-cluster-setup.sh
- This procedure might takes a while

    ```shell
    cd ~/Kubernetes-Cluster/

    nano env_setup.sh
    ./env_setup.sh
    ./k8s-docker-setup.sh

    # failing to pull docker image might happen sometimes, just keep trying with this script
    ./k8s-docker-pull.sh

    # proceed with this script after all docker images have been pulled successfully
    ./k8s-cluster-setup.sh
    ```

## Setup Master nodes and dashboard

- After **all** nodes are done with above settings, 6 nodes for this example
- Run k8s-master-etcd.sh with on **all master** nodes

    ```shell
    ./k8s-master-etcd.sh
    ```

- After **all** master nodes are done with above settings, 3 for this example
- It is essential to bring up all three etcd in the first place
- Setup SSH Key-Based Authentication to allow master-1 access master-2 and master-3
- Run k8s-master-setup.sh with on **all** master nodes

    ```shell
    ./k8s-master-setup.sh
    ```

- If not setting SSH Key-Based Authentication, you will be asked to enter passwords of master-2 and master-3
- After **all** master nodes are done with above settings, 3 for this example
- Run k8s-master-scale.sh with **sudo** on **one** of the master nodes

    ```shell
    ./k8s-master-scale.sh
    ```

- Access dashboard with url: https://ip-of-master-1:30000/
- Login dashboard with dashboard-token in master-1's output directory

    ```shell
    cat output/dashboard-token
    ```

## Setup Worker nodes

- After done with setting master nodes
- Get "kubeadm join" script on **one** of the master nodes in the output directory

    ```shell
    cat output/kubeadm-join
    ```

- Run the "kubeadm join" script with **sudo** on **all** worker nodes

    ```shell
    sudo kubeadm join ... --token ... --discovery-token-ca-cert-hash sha256:...
    ```

## (Optional) Label Worker nodes

- Label all the worker nodes with **sudo** on **one** of the master nodes

    ```shell
    kubectl label nodes <nodename> role=worker
    ```
