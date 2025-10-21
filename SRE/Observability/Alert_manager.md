"In my project, we set up Alertmanager as part of our Prometheus monitoring stack. Alertmanager’s main role is to handle alerts that Prometheus generates whenever a metric crosses a defined threshold or an anomaly is detected. For example, high CPU usage, memory saturation, pod crash loops, or service downtime.

In terms of setup, we configured Prometheus with an alert_rules.yml file where we define alerting conditions. For instance, if CPU usage is above 80% for more than 5 minutes, Prometheus will fire an alert. Prometheus then forwards these alerts to Alertmanager.

In Alertmanager, we configured different receivers like Slack, email, and PagerDuty. We also used grouping and inhibition rules—for example, if multiple nodes in the same cluster are down, Alertmanager groups those alerts together instead of sending 100 separate messages. This prevents alert fatigue.

The main purpose of Alertmanager in our project is incident management. It ensures the right people are notified at the right time and reduces noise by grouping and silencing non-critical alerts.

The benefits we saw were very clear:

Faster response time – Engineers get instant notifications instead of waiting to discover issues manually.
Reduced noise – Grouping and silencing prevented spam and helped us focus on critical issues.
Better reliability – Our system uptime improved because we could proactively fix issues before they became customer-facing incidents.
Team collaboration – Since alerts were integrated with Slack/PagerDuty, the on-call engineer could immediately see the problem and act.

So overall, Alertmanager gave us a centralized and automated way of handling production incidents, improving both system reliability and team efficiency.

**Below promQL expression used in alerting rules for traffic and reliability metrics.**
alert: HighErrorRate
expr: sum(rate(http_request_total{status=~"5.."}[5m]))
       /sum(rate(http_request_total[5m]))  > 0.1

http_request_total - this metrics counts total http_requests served by application.
status=~"5  -- filter only the requests with status code with 5 --shows that all requests that result in server error (5xx)
rate() -- calculates per second increase of counter over a given range.
[5m]  -- indicate 5-minute window of data.

rate(http_request_total[5m]) - average request per second over the last 5 minutes
rate(http_request_total{status=~"5.."}[5m]) --  5xx errors per second in the same time window.

sum() -
 suppose we have multiple pods, instance, micorservices exposing metrics. so sum() aggregate them all to get total traffic across your cluster.

sum(rate(http_request_total{status="5.."}[5m])) - Total errors requests per second across all pods
sum(rate(http_request_total[5m])) - Total request per second across all pods.

suppose we received 100 total request and 50 error request
     Then error rate = 50/100    = 0.05 (5%)

The condition > 0.1
This means --  if more than 10% of all requests resulting in 5* errors, then triggers an alert.

NodeHighMemoryUsage
node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes  < 0.1
Memory usage > 90%

PodRestartingFrequently
increase(kube_pod_container_status_restarts_total[5m]) > 3
pod restarted more than 3 times in 5 minutes.

TrafficDropDetected:
sum(rate(http_request_total[5m])) < 10


“Yes, I’ve configured alerting rules in Prometheus for both application and infrastructure metrics.
For example, to track API reliability, I created a rule that checks if 5xx errors exceed 10% over the last 5 minutes:
sum(rate(http_requests_total{status=~"5.."}[5m])) / sum(rate(http_requests_total[5m])) > 0.1.
I defined this inside a PrometheusRule YAML in the monitoring namespace.
When the condition is met, Prometheus sends the alert to Alertmanager, which handles grouping and routing.
In Alertmanager, I configured Slack and email receivers so the dev team gets notified instantly.
I also added node-level and pod restart alerts, and verified everything using Grafana dashboards by simulating failure scenarios.
So we have a complete, automated alerting pipeline from Prometheus to Slack


---------------------------------------







expr: kube_pod_status_phase{phase="Running", namespace="alert-test"} == 1



