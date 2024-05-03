# Installing Kubernetes with kubeadm
## _prerequisites_


- A compatible Linux host
- 2 GB or more of RAM per machine
- 2 CPUs or more
- Full network connectivity between all machines in the cluster
- Unique hostname, MAC address, and product_uuid for every node
- You MUST disable swap if the kubelet is not properly configured to use swap

## Implementing the prerequisites

- The first five line of the prerequisites will not be a problem since I am using a ec2 instanse from AWS, All these will be dealt with by AWS
- Swap memory should be disabled

## Swap memory

- Swap memory is a section of a computer's hard disk or SSD that the operating system (OS) uses to store inactive data from Random Access Memory (RAM)
- The default behavior of a kubelet was to fail to start if swap memory was detected on a node


## Step1 - Disabling swap memory

- Command to disabling the swap
```sh
sudo swapoff -a
```
- To make the swap persist across logins, make sure swap is disabled in config files like `/etc/fstab, systemd.swap`
- The following command will comment the swap in the fstab file
```sh
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```
## Step2 - Updating the ubuntu
```sh
sudo apt update
sudo apt upgrade
```

- Update command will fetch the latest information available in the repo to the machine, I will not do any changes to the packages already installed
- Upgrade command upgrades the installed packages on the system to their latest versions



## Step3 - Add Kernel Parameters (all nodes)


> sudo tee /etc/modules-load.d/containerd.conf <<EOF
> overlay
> br_netfilter
> EOF

```sh
sudo modprobe overlay
sudo modprobe br_netfilter
```
- The command will add the terms in the containerd config file, the modprobe command will import the kernel modules into the kernel

## Step4 - Configuring the critical kernel parameters for Kubernetes


> sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
> net.bridge.bridge-nf-call-ip6tables = 1
> net.bridge.bridge-nf-call-iptables = 1
> net.ipv4.ip_forward = 1
> EOF

- Reload the changes
```sh
sudo sysctl --system
```

## Step5 - Installation of container runtime

- There are three container runtime available in official doc ==containerd, docker engine, cri-o==
- Here I have installed containerd
- Installing the dependencies
```sh
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
```
- Enable the Docker repository

```sh
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```

- Update the package list and install containerd
```sh
sudo apt update
sudo apt install -y containerd.io
```
- Configure containerd to start using systemd as cgroup

```sh
containerd config default | sudo tee /etc/containerd/config.toml  >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
```

- Restart and enable the containerd service
```sh
sudo systemctl restart containerd
sudo systemctl enable containerd
```


## Step6 - Installing kubeadm, kubelet and kubectl

- Follow the official docs [Link](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

- Update the apt package index and install packages needed to use the Kubernetes apt repository
```sh
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
```
- Download the public signing key for the Kubernetes package repositories
```sh
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

- Add the appropriate Kubernetes apt repository.
```sh
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

- Update the apt package index, install kubelet, kubeadm and kubectl, and pin their version

```sh
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
```

## Step7 - Initialize Kubernetes Cluster with Kubeadm (master node)

```sh
sudo kubeadm init
```

## Step8 - Accessing the cluster
```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
- Now execute the command ==kubectl get nodes==, It will connect to the cluster and list the nodes



