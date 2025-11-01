𝗦𝗟𝗜: 𝗪𝗵𝗮𝘁’𝘀 𝗿𝗲𝗮𝗹𝗹𝘆 𝗵𝗮𝗽𝗽𝗲𝗻𝗶𝗻𝗴

This is just a number that tells you how your service is doing.
 Example:
"99.9% 𝘰𝘧 𝘰𝘶𝘳 𝘶𝘴𝘦𝘳𝘴 𝘨𝘰𝘵 𝘢 𝘳𝘦𝘴𝘱𝘰𝘯𝘴𝘦 𝘸𝘪𝘵𝘩𝘰𝘶𝘵 𝘦𝘳𝘳𝘰𝘳𝘴."

It measures Availabililty, Latency , error rate, throughput.
Eg. In the last 30 days 99.9% of HTTP requests responded with status code 200 within 500ms.
This is SLI for availability and latency.

How to measure SLI:-
1) Availability:-
prometheus + Grafana
we write promQL queries to measure success vs total requests.
rate(http_request_total){status=~"2.."}[5m])
/
rate(http_request_total[5m])

This gives % of successful HTTP responses in the last 5 minutes.

2) Latency:-
  Latency measures the time taken for a system to respond to request. in practice we track 95th or 99th percentile. meaning 95% of requests should complete within a defined threshold like 500ms or 1 second

  Tools like prometheus use http_request_duration_second_bucket to record response duration and histogram quantile(0.95..) is used to calculate p95 latency.

3) Error rate:-
  Error rate tracks the % of requests that fail, typically HTTP 500 status codes.it helps us catch issue early. even before users report them.

  rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m])

To calculate the ratio of failed request to total.

4) Throughtput: 
     throughput measures how many requests per second the system is handling. this help us understand system load and scalability.
      we use rate(http_request_total[1m]) in prometheus to see the per-second request rate.if it spikes it may indicate high load or potential DDos attack.

𝗦𝗟𝗢: 𝗪𝗵𝗮𝘁 𝘆𝗼𝘂 𝗮𝗶𝗺 𝗳𝗼𝗿

This is the target you want to hit.
 You set it to keep your service reliable.
 Example:
"𝘞𝘦 𝘸𝘢𝘯𝘵 𝘢𝘵 𝘭𝘦𝘢𝘴𝘵 99.9% 𝘴𝘶𝘤𝘤𝘦𝘴𝘴 𝘳𝘢𝘵𝘦 𝘦𝘷𝘦𝘳𝘺 𝘮𝘰𝘯𝘵𝘩."

𝗦𝗟𝗔: 𝗪𝗵𝗮𝘁 𝘆𝗼𝘂 𝗽𝗿𝗼𝗺𝗶𝘀𝗲 𝗼𝘁𝗵𝗲𝗿𝘀

This is a formal agreement with your customers.
 If you don’t meet it, there might be a penalty.
 Example:
"𝘐𝘧 𝘶𝘱𝘵𝘪𝘮𝘦 𝘥𝘳𝘰𝘱𝘴 𝘣𝘦𝘭𝘰𝘸 99.95%, 𝘸𝘦’𝘭𝘭 𝘨𝘪𝘷𝘦 𝘢 𝘱𝘢𝘳𝘵𝘪𝘢𝘭 𝘳𝘦𝘧𝘶𝘯𝘥."

𝗪𝗵𝘆 𝘀𝗵𝗼𝘂𝗹𝗱 𝘆𝗼𝘂 𝗰𝗮𝗿𝗲?
These are not just buzzwords. They help teams build better, more reliable systems and avoid late-night fire issues.

------------------------------------------------------------------------------------------------------------------------------------

MTTR  -Mean time to resolve

MTTR - Mean time to resolve/repair -- The average time it takes to resolve an outage and resolve service to end-users.
   MTTR = Total Downtime
          ---------------
          No of failure


MTBF - Mean time between failure  -- The average time from one incident to the next.
   MTBF = Mean time between failure
          --------------
          No of failure


MTTA- Mean time to acknowledge
         The average time it takes for a new open incident to be acknowledged.

          time to acknowledge 
          --------------------
          # of incidents

Error  udget and error rate 

Error Budget is == 100% Reliability - 0.1% Downtime.

![alt text](image.png)