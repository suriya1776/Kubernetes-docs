!#/bin/bash

#initize a api server and advertising api
kubeadm init --apiserver-advertise-address $(hostname -i) -- pod-network-cidr 10.5.0.0/16
#make dir for config
mkdir -p $HOME/.kube
#copy the config created and copy to your home
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#changing the ownership to user
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#export config path
export KUBECONFIG=/etc/kubernetes/admin.conf
#joining the node machine
kubeadm join 192.168.0.8:6443 --token c3u6xu.evrwojz3mvcw8ulv --discovery-token-ca-cert- hash sha256:22acffd2bc6c76faa4a8d0c3ba6e22ca2556b127f86641fb552e575d0c05f582
#For initlizing the network
kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml

