Question: You are managing an infrastructure setup on AWS for your company, which includes multiple services like EC2 instances, Lambdas, RDS instances, etc. Your company is looking to reduce AWS costs without hampering the performance or scalability. Explain how you would use Terraform to design and manage the infrastructure to achieve cost optimization.
Hint: Consider leveraging reserved instances, spot instances, right-sizing resources, choose appropriate storage classes, shut down idle resources, and auto-scaling. Also explain how terraform variables, modules and cloud-init scripts would assist in achieving the goal.

I will create a repository to store iac code and use a backend like s3 to store the state file.2. To communicate with s3 and dynamodb table (not needed if latest version of terraform is used) i will use gateway endpoint.
I will create MixedInstancesPolicy which will allow me to mix spot instance along with On-demand. In case I have a longer vision I will try to discuss with aws to get discount for 2-3 years. I will also ensure low utilisation instances are downsized or removed.
I will try to choose the right storage class for my buckets(if unsure I will use intelligent tiering and then study how the use is) also setup lifecycle for s3 buckets so that I only pay for the data which is used. Else it should be moved to cold storage or removed.
For lower environment I will ensure they are used during the business hours by using event bridge + lambda functions.Using this I can save cost on weekends and non business hours. Also I will try to go server less where ever possible. So that I end up paying for the compute cost alone.
I will use terraform to create all the resource so that it’s cloud agnostic and i can spin up resource in case something gets deleted.
I will setup prevent destroy lifecycle for all the essential resource so that they are not deleted by mistake. Also I will enable delete protection for my database.
I will setup ASG so that whenever load increase it would be served by spot instances. I will ensure I set minimum instance config such that application performance is not hampered.
I will create a budget and setup alerts when cost hits 65% and 85% of the budget.

What would you do to save costs on RDS? 
Use database caching
Use read replicas which would release pressure from the primary instance.
Ensure you do not take too many backups unless there is business justification.
Aurora could be used if you have unpredictable workloads

