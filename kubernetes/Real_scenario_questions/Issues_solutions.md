Zombie pods causing node drain.(s3 cleanUP failure)
Unable to drain node--> finalizers on pod-->pod is in terminating state--> finalizer controller pods in crashloopback--eks run managed API server manual intervention limited--manual removed finalizer.


kubectl drain node <node-name> --ignore-daemonsets --delete-emptydir-data --> hang
kubectl get pods --all-namespace | grep Terminating --> Pod is in terminating
kubectl describe pod <pod-name> - finalizer login on pod so unable to delete until cleanup login                                       execution.
kubectl get pods -n mycontroller-ns
kubectl logs s3-cleanup-controller-6c97b4d7d8-lq2v7 -n mycontroller-ns- access denied,
                                                because controller is not having permission to
                                                delete s3 bucket
reattach policy(s3:DeleteObject) and try again.

manual detete 
kubectl patch pod app-processor-9x72s -p '{"metadata":{"finalizers":[]}}' --type=merge

