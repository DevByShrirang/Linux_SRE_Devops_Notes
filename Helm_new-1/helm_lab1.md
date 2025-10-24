helm repo add mybitnami https://charts.bitnami.com/bitnami
helm repo list
helm repo update
$  helm install mynginx mybitnami/nginx---Install the nginx chart from mybitnami repository.and name this releaase mynginx.
NAME: mynginx
LAST DEPLOYED: Mon Jul 28 15:08:49 2025
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: nginx
CHART VERSION: 21.0.8
APP VERSION: 1.29.0

helm list
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART         A
PP VERSION
mynginx default         1               2025-07-28 15:08:49.0927584 +0530 IST   deployed        nginx-21.0.8  1

$ helm ls --output=yaml
- app_version: 1.29.0
  chart: nginx-21.0.8
  name: mynginx
  namespace: default
  revision: "1"
  status: deployed
  updated: 2025-07-28 15:08:49.0927584 +0530 IST

$ helm list --namespace=default
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
mynginx default         1               2025-07-28 15:08:49.0927584 +0530 IST   deployed        nginx-21.0.8    1.29.0

admin@DESKTOP-3I3NJDG MINGW64 /D/k88
$ helm list -n default
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
mynginx default         1               2025-07-28 15:08:49.0927584 +0530 IST   deployed        nginx-21.0.8    1.29.0


helm uninstall mynginx
Deletes all Kubernetes resources created by a Helm chart (e.g., Pods, Services, Deployments, PVCs).



________________________________________________________________________________________________________________________________

helm repo add stacksimplify https://stacksimplify.github.io/helm-charts/   --we have used custom chart from git repository.
helm install myapp1 stacksimplify/mychart1
helm upgrade myapp1 stacksimplify/mychart1 --set "image.tag=2.0.0"

$ helm list --deployed
NAME    NAMESPACE       REVISION        UPDATED                                 STATUS          CHART           APP VERSION
myapp1  default         2               2025-07-28 17:02:21.0415906 +0530 IST   deployed        mychart1-0.1.0  1.0.0

$ helm history myapp1
REVISION        UPDATED                         STATUS          CHART           APP VERSION     DESCRIPTION
1               Mon Jul 28 16:46:17 2025        superseded      mychart1-0.1.0  1.0.0           Install complete
2               Mon Jul 28 17:02:21 2025        deployed        mychart1-0.1.0  1.0.0           Upgrade complete


