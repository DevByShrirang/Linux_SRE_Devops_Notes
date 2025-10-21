kubectl get prometheusrule -n monitoring -- Command to check prometheus rule.

Important alerts
1) alert-PodCrashLooping.
expression - increase(kube_pod_container_status_restarts_total[5m]) > 0
for: 30s

--> This is counter metrics that counts how many times a container in a pod has been restarted.
    increase(..[5]) - calculated how many times a restart happended in last 5 minutes.
    if its greater than 0 then pods restarted recently.
    Alert fires only if the condition persist for 30 second.

2) Deployment-Down
expression: kube_deployment_status_replicas_available == 0
for: 1m

--> Is a gauge metrics that reports the number of pods currently available in the deployment.
     when it equals to 0 - The deployment has no healthy pods.
     Alert fires only after ensuring that deployment still down since last minute.





prometheus_rules.yaml

# Define the API version and kind of resource.
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule

# Metadata section identifies the rule group.
metadata:
  name: practical-rules                # Name of the PrometheusRule resource.
  namespace: monitoring                # Namespace where Prometheus is watching for rules.
  labels:
    prometheus: practical-rules        # Label to associate this rule with a specific Prometheus instance.

spec:
  groups:
  - name: node-alerts                  # Logical group name for organizing related alerting rules.
    rules:

    # Alert: PodCrashLooping
    # Detects if any pod has restarted in the last 5 minutes.
    - alert: PodCrashLooping
      expr: increase(kube_pod_container_status_restarts_total[5m]) > 0
      # The 'increase' function checks for restart count increments over a 5-minute window.
      for: 30s                          # Alert fires only if the condition persists for 30 seconds.
      labels:
        severity: warning              # Severity level—can be used for routing in Alertmanager.
      annotations:
        summary: "Pod {{ $labels.pod }} is restarting"
        description: "Pod {{ $labels.pod }} in namespace {{ $labels.namespace }} has restarted in the last 5 minutes"
        # These annotations provide human-readable context in alert notifications.

    #  Alert: DeploymentDown
    # Triggers when a deployment has zero available replicas.
    - alert: DeploymentDown
      expr: kube_deployment_status_replicas_available == 0
      # This checks if the deployment is completely unavailable.
      for: 1m                           # Alert fires if the condition holds for 1 minute.
      labels:
        severity: critical             # Higher severity—indicates a major outage.
      annotations:
        summary: "Deployment {{ $labels.deployment }} is completely down"
        description: "Deployment {{ $labels.deployment }} in namespace {{ $labels.namespace }} has 0 available replicas"
     - alert: PodRecovered
       expr: kube_pod_status_phase{phase="Running", namespace="alert-test", app=~".+"} == 1
       for: 2m
       labels:
         severity: info
       annotations:
         summary: "Pod {{ $labels.pod }} has recovered"
         description: "Pod {{ $labels.pod }} in namespace {{ $labels.namespace }} is now running again."