# High Availability Kubernetes Cluster

## Setup physical/virtual machines:

- Hostname: kube-master/worker-#
- OS: Ubuntu 16.04+
- CPU: 2+
- RAM: 2G+
- ROM: 16G+
- Required packages: openssh-server

    ```shell
    # you must have this package to manage your cluster
    sudo apt install -y openssh-server
    ```

- If you are using virtual machines, configure network settings on these machines:

    ```shell
    sudo nano /etc/network/interfaces
    ```

    ```
    auto ens160
    iface ens160 inet static
            address 10.106.6.151  # change to whatever ip you are using
            netmask 255.255.255.0
            gateway 10.106.6.254
            dns-nameservers 172.30.1.105 172.30.1.106
    ```

- If using Ubuntu 18.04+, run following commands on the machine (not through ssh) after editing config:

    ```shell
    sudo ip a flush ens160
    sudo systemctl restart networking.service
    ```

- Reboot the machine to enable network settings

    ```shell
    sudo shutdown -r now
    ```

- Setup 3 kube-master nodes and 3 kube-worker nodes for this example.
- In addition, setup 1 kube-dbs node for building a private docker registry if needed. [Tutorial](https://docs.docker.com/registry/deploying/)
- You'd better use SSH Key-Based Authentication on your main machine to access those nodes. [Tutorial](https://www.digitalocean.com/community/tutorials/how-to-configure-ssh-key-based-authentication-on-a-linux-server)
- After the above settings are done, clone this repository to your main machine, edit the username and ip in scp.sh, and use it to copy files we need to K8s machines.

    ```shell
    git clone https://github.com/brianisadog/Kubernetes.git
    cd Kubernetes/
    nano scp.sh
    ./scp.sh
    ```

## Setup Kubernetes cluster:

- Go to [Kubernetes-Cluster](Kubernetes-Cluster/) and follow the instruction.

## Setup Terraform on your local machine:

- Go to [Terraform-Kubernetes](Terraform-Kubernetes/) and follow the instruction.
