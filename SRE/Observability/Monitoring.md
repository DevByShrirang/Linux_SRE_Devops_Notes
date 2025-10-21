white-box monitoring- gives the internal visibility of server/system through metrics exposed by system itself.
metrics - cpu usage, disk usage, memory i/o , load average
application-level metrics- request_processing_time, request_errors_total.

black-box monitoring - gives idea about external behaviour of system without knowledge of internal workings.
eg - ping test, HTTP requests, uptime, API response time.

--

Four golden signals of monitoring.
latency   - Time taken to serve a request.   -- HTTP response time. DB query time.
traffic   -  amount of demand on system.     -- request per second (RPS)
errors    - rate of failed requests.          --5000 errors timeout rates
saturation  -  resource usage vc total capacity  - cpu usage , memory utilization.