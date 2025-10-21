Pod Lifecycle: From kubectl apply to Running Pod
1. You apply the Deployment

You run:

kubectl apply -f deployment.yaml


kubectl sends the YAML manifest to the API Server.
The API Server stores the desired state (Deployment, ReplicaSet, Pod specs) into etcd (the cluster’s source of truth).

2. Deployment & ReplicaSet

The Deployment Controller in the Controller Manager sees the new Deployment object.
It creates a ReplicaSet that matches the desired replicas.
The ReplicaSet then creates the required Pod objects (still just definitions in etcd, not running yet).

3. Scheduler assigns the Pod to a Node

The Scheduler looks at pending Pods (those without a node assigned).
It considers scheduling rules (resources, affinity/taints/tolerations, etc).
It updates the Pod spec in etcd with the chosen nodeName.

👉 Now the Pod is bound to a node, but not running yet.

4. Kubelet on that Node takes over

The kubelet (node agent) watches the API Server.
It sees a Pod scheduled to its node.
Kubelet communicates with the container runtime (containerd, CRI-O, or Docker in older clusters) to create the containers.

5. Pod Sandbox & Networking Setup

Before creating containers, kubelet asks the runtime to create a pod sandbox (the network namespace for the pod).
The runtime calls the CNI plugin (Container Network Interface).

CNI does:

Allocates an IP for the pod (via AWS VPC CNI in EKS, Calico, Flannel, etc).
Creates a veth pair (one end inside pod as eth0, one on the host).
Sets up routing + iptables/ebpf rules.
Now the pod has an IP and can talk within the cluster.

6. Image Fetch & Container Creation

Container runtime pulls the image from the registry (Docker Hub, ECR, GCR, etc), unless it already exists locally.
It unpacks the image, sets up the container filesystem.
The container is created inside the pod’s sandbox (with the IP from CNI).

7. Kubelet starts Probes & Reports Status

Kubelet starts liveness/readiness/startup probes (if defined).
It updates Pod status back to API Server → etcd.
The Pod moves from Pending → Running.

8. Service/Endpoints update

If the Pod is part of a Service, the kube-proxy updates iptables/IPVS rules on nodes to send traffic to this Pod.
The Endpoints Controller in control plane also updates the list of healthy Pods behind the Service.

🔹 Key Players (Summary)

Here’s who does what:

kubectl → Sends manifest to API Server.
API Server → Validates & stores spec in etcd.
Controller Manager → Deployment → ReplicaSet → Pod objects.
Scheduler → Decides which node runs the Pod.
Kubelet (on Node) → Talks to container runtime, pulls image, manages lifecycle.
Container Runtime (containerd/CRI-O) → Actually creates containers.
CNI Plugin → Assigns Pod IP, sets up networking.
kube-proxy → Ensures Pod is reachable via Service.


![alt text](<WhatsApp Image 2025-09-30 at 21.21.36_5d7adae5.jpg>)