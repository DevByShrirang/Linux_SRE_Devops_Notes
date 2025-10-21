1️⃣ Core Kubernetes Concepts (must-know / high priority)

Pods
Pod lifecycle, states, restart policies
Pod networking, pod IPs, hostNetwork, DNS resolution
Multi-container pods and sidecars
Deployments & ReplicaSets
Rolling updates, rollbacks, scaling
Strategies: recreate vs rolling update

Services

ClusterIP, NodePort, LoadBalancer, ExternalName
How services provide stable DNS & load balancing
Pod-to-pod communication via service
Namespaces
Resource isolation, RBAC scoping, service DNS resolution

2️⃣ Config & Secrets Management

ConfigMaps and Secrets (volume mount & env vars)
Encrypted secrets with KMS provider
Best practices for secret management

3️⃣ Storage / Volumes

Persistent Volumes (PV) and Persistent Volume Claims (PVC)
StorageClasses and dynamic provisioning
Volume types: hostPath, NFS, AWS EBS, Azure Disk, GCP PD

4️⃣ Networking (showing expertise)

Cluster networking model (CNI)
Pod-to-Pod communication (same/different nodes)
Network policies (allow/deny traffic)
Ingress & Ingress Controllers (NGINX, ALB, Traefik)
DNS resolution in Kubernetes (kube-dns, CoreDNS)
Service discovery across namespaces

5️⃣ Scheduling & Resources

Node, Pod, and Taint/Toleration concepts
Affinity & anti-affinity rules
Resource requests & limits (CPU/memory)
QoS classes (Guaranteed, Burstable, BestEffort)

6️⃣ Helm & Package Management

Helm charts: structure, values, templates
Helm upgrade, rollback, dry-run
Using Helm in CI/CD pipelines

7️⃣ Cluster Administration / Maintenance

Node management (cordon, drain, delete)
Cluster upgrades (kubeadm / managed EKS/GKE/AKS)
Monitoring node & pod health
Logs & troubleshooting (kubectl describe, kubectl logs)

8️⃣ Observability / Logging / Monitoring

Prometheus & Grafana integration
Metrics-server & HPA (Horizontal Pod Autoscaler)
Liveness & readiness probes
Centralized logging with Fluentd / ELK

9️⃣ Advanced / Expert Level (sets you apart)

RBAC: roles, rolebindings, clusterroles, clusterrolebindings
Service Accounts & IAM integration (IRSA in AWS)
Pod Security Standards & Policies
Custom Resources (CRD) & Operators
Multi-tenancy considerations
Cluster autoscaling & Pod autoscaling
Canary / Blue-Green deployments (Argo Rollouts or custom)
Etcd backup & restore
Network troubleshooting: kubectl exec, tcpdump, nslookup in Pods

🔹 Suggested Approach for Interview

Start with core concepts: Pod, Deployment, Service, ConfigMap, Secret.
Demonstrate practical knowledge: Helm, CI/CD integration, scaling, HPA.
Show security & admin expertise: RBAC, non-root Pods, network policies.
End with advanced topics: CRDs, operators, multi-namespace service communication, canary deployments.






1. Kubernetes & Containerization – 30%

JD mentions: Strong hands-on on Kubernetes, pod/container networking, creating/maintaining clusters (cloud & on-prem)

This is clearly the core skill they want. Expect deep questions on:

Pods, Deployments, Services, Ingress

Probes (readiness/liveness/startup)

Networking (CNI, service discovery, DNS, kube-proxy, IP assignment)

Storage & Persistent Volumes

Scaling & autoscaling

Troubleshooting (OOMKilled, CrashLoopBackOff, networking issues)

2. CI/CD & DevOps Tooling – 25%

JD mentions: Git, Jenkins, GitLab CI, pipelines, Artifactory, Helm

Expect questions on:

Building CI/CD pipelines (especially for microservices)

Jenkins pipeline syntax (declarative vs scripted)

Git branching strategies (GitFlow, trunk-based)

Artifact management (Nexus, Artifactory)

Helm charts for Kubernetes deployments

3. IaC & Automation – 20%

JD mentions: Terraform, Ansible, Chef, Puppet

They may not ask you everything but focus on Terraform and Ansible, since these dominate today’s infra automation.

Expect:

Terraform state, modules, workspaces, taint, drift detection

Writing Ansible playbooks/roles, idempotency

Infrastructure provisioning and automation workflows

4. Scripting & Programming – 10%

JD mentions: Shell, Python

They will check if you can:

Write automation scripts (e.g., log parser, simple deployment automation)

Use Shell scripting for day-to-day ops tasks

Use Python for slightly advanced automation (file handling, REST API calls, parsing JSON/YAML)

5. Cloud & Environment Management – 10%

JD mentions: Cloud + On-prem clusters, multi-env (Dev, QA, Prod, etc.) setups

Expect:

How to set up infra in cloud (AWS/GCP/Azure)

Environment promotion strategies (Dev → QA → Prod)

Secrets management (Vault, KMS, sealed-secrets)

Production-grade best practices (monitoring, scaling, HA)

6. Miscellaneous (Build Tools, Repo Mgmt, TDD, Fundamentals) – 5%

JD mentions: Ant, Maven, Gradle, Nexus, TDD mindset, Linux fundamentals, algorithms

These will come up, but more as secondary/confirming skills.

Examples:

Linux commands (grep, awk, systemctl, journald, networking tools)

Basics of Java build tools (just to confirm familiarity)

TDD – high-level process understanding, not deep coding

Focus Summary