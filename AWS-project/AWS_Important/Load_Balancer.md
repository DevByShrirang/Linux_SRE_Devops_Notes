ASG launches 2 EC2 instances based on minimum capacity.
ELB gets those 2 instances registered as targets.
Users start sending traffic → ELB balances it between the two.
Suddenly, traffic spikes at 8 PM.
CloudWatch Alarm triggers ASG to add 2 more EC2s.
ASG launches EC2s, and ELB automatically starts routing traffic to them.
After midnight, traffic drops → ASG scales in and removes 2 instances.
ELB stops routing to terminated instances.

