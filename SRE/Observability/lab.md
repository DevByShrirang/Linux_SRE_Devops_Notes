Step 1: Create a Kind Cluster

kind-config.yaml

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: prometheus-test
nodes:
  - role: control-plane
  - role: worker
  - role: worker

  kind create cluster --config kind-config.yaml