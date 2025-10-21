**feature of promethues**
📊 Multi-dimensional data model: In prometheus metrics are stored and queried with labels. that gives flexibility, scalability,and rich querying ability.
🌐 Accessible format and protocols: Prometheus metrics are published using a straightforward HTTP transport, making them easily accessible and human-readable with self-explanatory formats.
🔎 Service discovery: prometheus supports dynamic discovery of targets without manually adding them to configuration.
🔌 Modular and high availability: Prometheus is built with modular components that handle tasks like metric gathering, alerting, and visualization. These components are designed to support sharding and redundancy, ensuring high availability.


🔍 It collects metrics such as CPU usage, memory usage, request counts, and exceptions. These metrics are referred to as "Metrics".

🎯 Prometheus categorizes metrics into three types:

Counter: - we use counter to track total number of order placed. eg order_placed_total metrics increase every time.
Gauge: we used gauge to track the number of active users currently browsing the site. 
Histogram: used to track request latencies.  http_request_duration_seconds tracks how long request takes and how often they fall into different ranges like <0.5s, 0.5-1s, >1s.

**Node-exporter** - Node exporter collects metrics from targets, converts them into prometheus-readable format, and expose /metrics endpoint.
**Alert manager** - Responsible for sending alerts via slack, , email, in case of cluster failure or resource limitations.
**storage**:-💾 Data collected by Prometheus is stored in a local disk or can be connected to remote storage.
**promql** -query language used by prometheus to query and extract metrics from its time series database.
          A) retrieve data - fetch raw metrics from prometheus.
              http_request_total - returns all time series for the metrics http_request_total.
           B) Filter data - use label matches to filter specific metrics.
              http_requests_total{method='GET'} - Returns only metrics where label method=GET
           C) Aggregate data - summerise metrics across dimensions.
              sum(http_requests_total) by (instance)
           D) calculate rates and changes-
              rate(http_requests_total[5m]) -->calculate the per second rate of increase over the past 5 minites.
           E) Create alerts - 
              rate(http_requests_total[5m]) > 100
              Triggers an alert if the request rate exceeds 100 requests/sec.

average cpu usage per node over the last 5 minutes.
avg(rate(node_cpu_seconds_total{mode="user"}[5m])) by (instance)


prometheus.yml

global:
  scrape_interval: 15s   # How often to scrape targets
  evaluation_interval: 15s  # How often to evaluate rules

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]

  - job_name: "node_exporter"
    static_configs:
      - targets: ["192.168.1.10:9100", "192.168.1.11:9100"]

alerting:
  alertmanagers:
    - static_configs:
        - targets: ["localhost:9093"]

rule_files:
  - "alert_rules.yml"


configuration file is a total information about how ofter we scarpe metrics from targets
we put target information in configuration file so promethues able to scarpe metrics from targets.
we set alerting in configuration file and we provided alerting condition in alert_rules.yml.

kubectl exec -it prometheus-prometheus-stack-kube-prom-prometheus-0 -n monitoring -- sh -c "cat /etc/prometheus/prometheus.yml"