1. Blue/Green Deployment — Example

“In my last project, we were migrating a critical payment processing service. Downtime was not acceptable, so we implemented a Blue/Green deployment.
We provisioned a parallel environment in AWS using Terraform — same setup as production. The new version was deployed there, tested with staging traffic, then we switched the Application Load Balancer to route 100% of traffic to the new environment.
When we detected a bug during post-deployment monitoring, rollback was as simple as switching back the load balancer to the previous environment, which we did without any downtime.
This approach reduced risk and gave us confidence for critical releases.”

2. Canary Deployment — Example

“In a SaaS project with millions of users, we wanted to minimize the blast radius for new features.
We used Kubernetes with Istio service mesh to perform Canary deployments. The new version of our microservice was initially deployed to 10% of traffic. We monitored metrics — error rates, latency, and CPU usage — using Prometheus and Grafana.
After confirming stability for 24 hours, we gradually increased traffic to 50% and then to 100%.
This gave us real-time validation and confidence, and in one case, we detected an unexpected latency spike at 30%, so we paused the rollout and fixed the issue before full deployment.
This Canary approach reduced deployment risk and improved system stability.”

3. Rolling Deployment — Example

“For one of our Kubernetes-based microservices, we implemented a Rolling update strategy.
We used Kubernetes Deployments with maxUnavailable=1 and maxSurge=1 so pods were updated one at a time.
During deployment, Kubernetes terminated one old pod, started a new one, waited for it to pass readiness probes, and then moved to the next.
This ensured zero downtime while updating, and the rollout could be monitored via kubectl rollout status.
If a pod failed its readiness probe, Kubernetes paused the rollout so we could investigate. This approach was automated via our CI/CD pipeline, making deployments safer and faster.”


3️⃣ Switch the Traffic

Option 1: Update Kubernetes Service

Your Service object defines the selector for pods.

Update the label selector to point from blue pods → green pods:

kubectl set selector svc/myapp app=green


Option 2: Use Helm Upgrade

Helm can manage versioned deployments with values.yaml.

Update the image.tag and run helm upgrade.

Option 3: Use ArgoCD GitOps Approach

Update the Helm chart in the GitOps repo with the new tag.

ArgoCD automatically reconciles and switches traffic to green pods.

Interview phrase:

“I update the Kubernetes service or the Helm chart to point traffic from blue pods to green pods, so the new version starts serving live users.”