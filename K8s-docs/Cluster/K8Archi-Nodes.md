## Cluster Architecture and nodes

![cluster architecture](https://kubernetes.io/images/docs/kubernetes-cluster-architecture.svg)

## Nodes

- Every node is managed by the control plane and contains the services necessary to run Pods
- The components on a node include the kubelet, a container runtime, and the kube-proxy

## Node management

There are two ways you can add the nodes to the api server

- The kubelet on a node self-registers to the control plane
- You (or another human user) manually add a Node object

After creation of node object, kubelet self registers node to the control plane, control plane check whether the node is valid or not

Kubernetes creates the node internally, kubernetes check if the kubelet is registered to the API server with the name matches, checks the healty state of the node, if the node is not healthy it is ignored for any operations, It will continue to check the state of the node.

## Node name uniqueness

Two objects in k8s cannot have a same name.

## Self-registration of Nodes

Not getting into node creation and all, since kudeadm takes care of these, below is the command to unschedule a node
```sh
kubectl cordon $NODENAME
```
## Node status

Node status contains the following information

- Addresses
- Conditions
- Capacity and Allocatable
- Info

command used to describe the node

```sh
kubectl describe node <nodename>
```

## Addresses

- Hostname - The hostname as reported by the node's kernel. Can be overridden via the kubelet --hostname-override parameter
- ExternalIP: Typically the IP address of the node that is externally routable (available from outside the cluster)
- InternalIP: Typically the IP address of the node that is routable only within the cluster

## Conditions

The conditions field describes the status of all Running nodes

- Ready 
-- True - If the node ready to run the pods
-- False - If the node is not ready to run any pods
-- Unknown - If the Node controller has not heard from the node within the grace period (node-monitor-grace-period default is 40s)

- DiskPressure
-- True - If disk capacity is low
-- False - Fine

- MemoryPressure
 -- True - If node memory is low
 -- False - Fine

- PIDPressure
 -- True - If pressure exist on any proccesses
 -- False - Fine

- NetworkUnavailable
 -- True - if network is not correctly in node
 -- False - Fine


When problem araises controller creates taint that matches the condition

## Capacity and Allocatable

Describes the resources available on the node: CPU, memory, and the maximum number of pods that can be scheduled onto the node.

> Capacity:
  cpu:                8
  ephemeral-storage:  65504Mi
  hugepages-1Gi:      0
  hugepages-2Mi:      2378Mi
  memory:             32946972Ki
  pods:               110
Allocatable:
  cpu:                8
  ephemeral-storage:  65504Mi
  hugepages-1Gi:      0
  hugepages-2Mi:      2378Mi
  memory:             30511900Ki
  pods:               110


## Info

Describes general information about the node, The kubelet gathers this information from the node and publishes it into the Kubernetes API

## Node controller

The node controller is a Kubernetes control plane component that manages various aspects of nodes

The node controller has multiple roles in a node's life. The first is assigning a CIDR block to the node when it is registered (if CIDR assignment is turned on).

The node controller will have the list of nodes, if any node machine is not available it will delete the node from the list

