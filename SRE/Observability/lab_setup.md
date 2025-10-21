Installation of metrics server using helm
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm repo update
 Below command for docker desktop to skip kubelet TLS validation
helm install metrics-server metrics-server/metrics-server \
  -n kube-system \
  --set args={--kubelet-insecure-tls}


$ kubectl get pods -n monitoring
NAME                                                     READY   STATUS    RESTARTS   AGE
alertmanager-prometheus-stack-kube-prom-alertmanager-0   2/2     Running   0          15m
prometheus-prometheus-stack-kube-prom-prometheus-0       2/2     Running   0          15m
prometheus-stack-grafana-5c8d5c8879-hxn6g                3/3     Running   0          16m
prometheus-stack-kube-prom-operator-6bcbf5488f-lhvn7     1/1     Running   0          16m
prometheus-stack-kube-state-metrics-5dc4bdf888-vd7dr     1/1     Running   0          16m
prometheus-stack-prometheus-node-exporter-h54xj          1/1     Running   0          16m
prometheus-stack-prometheus-node-exporter-q79zq          1/1     Running   0          16m

kube-prometheus-stack.
alertmanager working as a pod in stack. it receives alerts from prometheus pod.
alert-manager duplicates, groups and route alert as notification via email,slack.
prometheus working as a pod in stack its function is to scarpe metrics from target(node exporter, kube-state-metrics,custom apps) and store in time series database and sending alert to alert manager.
grafana application working as pod. grafana provides visualization for prometheus metrics and helps in creating dashboard for cluster monitoring.
prometheus operator- its function is to automate deployment, scaling, and configuration of prometheus staack.
kube-state-metrics exporter- kube state metrics converts k8 objects states into metrics, which prometheus then scrapes.
node exporter- node exporter running on each node. it collects system level metrics cpu, memory,disk,network, filesystem usage.


--\\\\\\---------\\\\\\\\\\\\\\\-------------------------//////////////----------------/////////////
kube-proxy
$ kubectl get pods -n kube-system
 NAME                                            READY   STATUS    RESTARTS      AGE
coredns-7c65d6cfc9-js5d9                        1/1     Running   0             3d19h
coredns-7c65d6cfc9-ts46p                        1/1     Running   0             3d19h
etcd-desktop-control-plane                      1/1     Running   0             3d19h
kindnet-dvzhc                                   1/1     Running   0             3d19h
kindnet-jvtwx                                   1/1     Running   0             3d19h
kube-apiserver-desktop-control-plane            1/1     Running   0             3d19h
kube-controller-manager-desktop-control-plane   1/1     Running   9 (61m ago)   3d19h
kube-proxy-fqbsw                                1/1     Running   0             3d19h
kube-proxy-wxgb9                                1/1     Running   0             3d19h
kube-scheduler-desktop-control-plane            1/1     Running   7 (61m ago)   3d19h
metrics-server-fbb76bc7f-vgfq6                  1/1     Running   0             53m

Expose services to NodePort(grafana,prometheus,alertmanager)
kubectl edit svc prometheus-stack-grafana -n monitoring
kubectl edit svc prometheus-stack-kube-prom-prometheus -n monitoring
kubectl edit svc prometheus-stack-kube-prom-alertmanager -n monitoring

grafana password-=:--
admin@DESKTOP-3I3NJDG MINGW64 /d/prometheus_final
$ kubectl get secret prometheus-stack-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode
prom-operator

----------------------------------------------