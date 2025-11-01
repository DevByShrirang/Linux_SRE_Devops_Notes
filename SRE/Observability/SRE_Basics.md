SRE - Site reachability engineer-
 Relaibility can be seen as
 
 Probability of Success - System request will success (no errors)    Tied to error rate key SLI(99.99%)
 Durability - Data remains safe over time (s3 durability )           SRE care for data integrity & persistence
 Dependability - Users trust that system will behave as expected.    Build via monitoring . alerting and SLO
 Quality over time- system consistently performs without degrading   Monitored via latency , throughput ,p99metrics
 Availability- System is up and can respond to user requests         tracked via availability SLIs, & SLOs.

 Responsibility of SRE organization-
 Availability - 
 performance -
 Incident management-
 Monitoring-

 
SLA is a document which is having SLO(service level objects)

service should be running 99.99% throught the year.
response time will be 30 ms.

we do SLA with the customer. and there are someone who  taking care to meet this SLA 
there is dedicated team who always work on to meet the SLA

IF Service level objectives(SLO) are in risks then they should send alert to the development team or they should take required 
action. This team also called as site reliability engineer.

SDLC
web app - need to understand flow of the application, how user interacts with the context path of the application.
linux -
docker - 
kubernetes
observability -- Obervability is the framework that tells SRE engg. if the SLO are meet
                  or not.
                 1) Metrics - Dashboard-
                  SRE engg. configure metrics for the objectives. they create dashboard to ensure the metrics are met or 
                   expectations are met.
                2) LOG- ELK --They set up log environment that is ELK stack
                3) Trace - And they also enable distributed tracing.
Incident management - As SRE engg we should be good at incident management. because sometime metrics fails ans immediately you would get alert. so as SRE enginner we would also setup alertand this alert received may be in the night or in day. so we need 
to know how to manage incident.so we need to respond to customer within SLA. 

RCA/ debugging /trouleshooting.

Very important and day to day basis terms used by SRE engineers.
SLA -Service level aggrement
SLO - service level objectives
SLI - Service level indicator

Error budget
Toil
RCA



https://www.youtube.com/watch?v=sL7h1rOn0K0&list=PLhqPDa2HoaAZcamYtXr-ijXBT-vcUBcNX