## ETCD basics

ETCD is a distributed reliable key value store that is simple,secure and fast
Will store all the datas of the cluster in a key value format 

There are we ways  we can deploy a etcd server, one is manually from sratch and one is by kubeadm tool


## Kube api server

Initial request from kubectl is sent to kube api server, it will follow the below steps

- Authenticate user
- Validate request
- Retrive data
- Update etcd
- Send data to scheduler
- Kubelet

# Kube control manager

Continiously monitures the status of the nodes , if the system is down it will try to bring it back


# Kube scheduler

It will decide to place the pods on the nodes, will not be responsible running the pods in a nodes that is taken care by kubelet

# Kubelet

Kubelet is a agent that runs on every node and continously communicates with the kube api server shares all the datas of a nodes , it will

- Register the nodes 
- Creates a pods
- Monitures the pods and node


# Kube proxy
This is used for internal communication between the pods within the cluster
## Pods
It is the smallest components in the nodes, it is a running application inside a node
