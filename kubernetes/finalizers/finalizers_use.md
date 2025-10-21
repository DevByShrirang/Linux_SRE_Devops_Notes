A finalizer is a Kubernetes mechanism that prevents an object from being deleted until some cleanup logic is completed.

🔍 Why Finalizers Are Used:
Controllers use finalizers to:
Safely clean up cloud resources (e.g., EBS volumes, firewall rules)
Run custom logic before an object is fully deleted
Avoid orphaned or leaking resources.

In my project, we used finalizers to ensure safe cleanup of cloud resources provisioned by Kubernetes.
For example, when a developer deleted a PVC, Kubernetes added a finalizer (kubernetes.io/pvc-protection). That prevented accidental deletion of the underlying AWS EBS volume until our CSI driver had safely detached and cleaned up the storage.