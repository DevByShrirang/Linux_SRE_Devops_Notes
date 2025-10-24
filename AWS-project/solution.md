You can use the following project solution to perform a self-evaluation of your project. If you have not completed all the tasks for the project, you may want to 
go back and complete all the tasks before reviewing the project solution.


Project solution
Task 1: Launch EC2 instances

Step 1

Use the Amazon Linux 2 AMI and t2.micro instance type.
Via AWS Console or CLI:
aws ec2 run-instances \
  --image-id ami-0c2b8ca1dad447f8a \
  --count 2 \
  --instance-type t2.micro \
  --key-name <Your-Key-Name> \
  --security-groups <Your-Security-Group>
Two EC2 instances launched successfully.





Step 2

Open ports 22 (SSH) and 80 (HTTP).
You can do this via:
AWS Console (during instance setup)
Or modify an existing security group




Step 3
After launch, note the public IP or DNS of both instances from the EC2 Dashboard for browser access later.


Task 2: Deploy the web application

Step 1

ssh -i <Your-Key-Name>.pem ec2-user@<Instance-Public-IP>
Step 2
Run the following commands on each instance:

sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo '<h1>Hello from EC2 Instance 1</h1>' | sudo tee /var/www/html/index.html
Sample web page hosted successfully on both instances







Step 3

Open the public IP or DNS in your browser:
http://<Instance-1-Public-IP>
http://<Instance-2-Public-IP>
You should see each respective HTML message.

Task 3: Set up the load balancer

Step 1

Go to EC2 > Load balancers > Create Load Balancer
Choose Application Load Balancer
Scheme: Internet-facing
Listener: HTTP on port 80
Select the same VPC and subnets as instances
Step 2

Type: Instance
Protocol: HTTP, Port: 80
Register both EC2 instances in the group
Step 3

Default path: /
Protocol: HTTP
Thresholds can remain default for basic testing






The load balancer has been created and configured successfully.

Task 4: Test the load balancer traffic distribution

Step 1

Get the DNS name of the load balancer from the AWS Console
Open in your browser: http://<ALB-DNS-Name>
Step 2

Refresh the page multiple times
You should see alternating messages:
Hello from EC2 Instance 1
Hello from EC2 Instance 2
Step 3

Stop one EC2 instance temporarily.
Reload the load balancer URL.
Traffic should now only go to the healthy (running) instance.


Load balancer traffic distribution has been successfully verified.


Previous

Next
