Helm Version & Info
helm version
helm env

Use: Check Helm client & server versions, and environment variables like chart repository locations.

Searching and Adding Repositories
helm repo add <name> <repo_url>
helm repo list
helm repo update
helm search repo <chart_name>

Use: Manage Helm repositories and search for charts.
Interview tip: Show you can configure both public (Bitnami) and private Helm repos.

Installing a Release
helm install <release_name> <chart_name> --namespace <ns> --values values.yaml

Use: Deploy a new application in Kubernetes.
Explanation: Helm combines chart templates + values.yaml → generates manifests → applies to cluster.

Upgrading a Release
helm upgrade <release_name> <chart_name> --set image.tag=2.0.0
helm upgrade <release_name> <chart_name> -f values.yaml

Use: Deploy a new version of the app (rolling update).
Explanation: Only changes in templates or values trigger updates. Previous version is retained in release history.

Rollback a Release
helm rollback <release_name> <revision_number>

Use: Revert to a previous release version if the new deployment fails.
Interview tip: Always mention Helm tracks release history by revision number

Checking Status
helm status <release_name>
helm list --all-namespaces

Use: Verify release status, deployed chart version, namespace, and notes.

7️⃣ Uninstalling a Release
helm uninstall <release_name> --namespace <ns>

Use: Delete a release and all associated resources.
Tip: Can include --keep-history if you want to retain release info.

8️⃣ Template & Dry Run
helm template <chart_name> --values values.yaml
helm install <release_name> <chart_name> --dry-run --debug

Use: Preview Kubernetes manifests before applying.
Interview tip: Shows you know how to validate Helm charts safely.

9️⃣ Inspecting Values
helm show values <chart_name>
helm get values <release_name>

Use: See default chart values or deployed values for a release.

10️⃣ Helm Diff (Optional but Advanced)
helm plugin install https://github.com/databus23/helm-diff
helm diff upgrade <release_name> <chart_name>

Use: Compare current deployed release vs new chart changes.
Interview tip: Shows expertise in safe deployment practices.
