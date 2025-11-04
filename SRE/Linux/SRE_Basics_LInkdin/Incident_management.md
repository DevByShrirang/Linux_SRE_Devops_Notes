Incident Management is the process of detecting, responding to, communicating, and resolving production issues as quickly and efficiently as possible to minimize user impact.
**It’s a core function of SRE**

1. Purpose

Restore normal service as quickly as possible
Minimize MTTR (Mean Time To Resolve)
Ensure clear communication internally and externally
Learn from incidents through postmortems

💬 Interview line:

“Incident management is about responding quickly, communicating clearly, and preventing recurrence — not just fixing the symptom.

2. Incident Response Flow (Simple 5 Steps)

Detection → via monitoring/alerts (Prometheus, Datadog, CloudWatch)
Response / Acknowledgment → On-call engineer gets notified (PagerDuty, OpsGenie)
Diagnosis → Identify root cause or workaround
Resolution → Restore service
Postmortem → Capture lessons & corrective actions

✅ Easy memory trick → D-R-D-R-P
(Detect → Respond → Diagnose → Resolve → Postmortem)

3. Incident Command System (ICS) Model

Adopted from emergency services, it defines clear roles during an incident:

Role	Responsibility
Incident Commander (IC)	Owns coordination and communication — “one person in charge.”
Responder(s)	Investigate and fix the issue.
Communicator / Liaison	Keeps management and customers informed.

💬 Interview line:

“We follow the Incident Command System — having a single Incident Commander avoids confusion and ensures structured communication.”