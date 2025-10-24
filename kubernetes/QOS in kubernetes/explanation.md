Quality of Service (QoS) in Kubernetes determines how the kubelet prioritizes Pods for resource allocation (CPU and memory) and which Pods get killed first when a Node runs out of resources.
helps to manage resource efficiently.
types:--
Gauranteed - 
pod is guaranteed getting requested resources. requests=limits for both cpu & memory -best  for production-critical workloads.

burstable -  pod gets resources it requests but can use more if available. --suitable for flexible workloads.

BestEfforts -- pods can use resources only when available. - No resource requests or limits defined.
     used for low-priority and non-critical workloads.


Eviction priority
When a Node runs out of memory or CPU, Kubernetes will evict Pods in this order:

1️⃣ BestEffort Pods → killed first
2️⃣ Burstable Pods → killed next
3️⃣ Guaranteed Pods → killed last (highest priority)
