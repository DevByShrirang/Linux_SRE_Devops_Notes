https://www.linkedin.com/in/narayana-reddy-562451249/

Interview-Asked--on which server you are executing all pileline stages?

🧩 Question:

“On which server are you executing all your Jenkins pipeline stages?”

✅ Short Answer (Direct Interview Style):

All my pipeline stages are executed on the Jenkins agent (node) — not directly on the Jenkins master.
The master only orchestrates the pipeline, while the actual build, test, scan, Docker build, and deployment stages run on an agent node, which can be 
a static EC2 instance or dynamically provisioned node in AWS.

💡 Detailed Explanation (For Deeper Discussion):
1️⃣ Jenkins Master (Controller):

Responsible for:

Managing jobs and pipelines.

Scheduling builds.

Sending tasks to the appropriate agents.

Handling web UI, configurations, and plugins.

It does not run the heavy build tasks itself (in production setups).

You have a private subnet with no internet access, but your instances need to download updates. How do you enable this securely?

IQ-Asked-2️⃣ Jenkins Agent (Node):

The actual execution happens here — every stage in your pipeline runs on an agent.

The agent connects to the master via JNLP or SSH.

The agent can be:

Static → e.g., a dedicated EC2 instance you manage manually.

Dynamic → e.g., an ephemeral EC2, Kubernetes Pod, or Docker container launched on-demand.

IQ-Asked-3️⃣ Where Each Stage Runs (Example from Your Pipeline):
Stage	Runs On	Description
Git Checkout	Jenkins agent	Clones repo using Git credentials
SonarQube Analysis	Jenkins agent	Runs SonarQube scanner CLI
npm install / Unit Tests	Jenkins agent	Application build steps
Trivy Scan	Jenkins agent	Security scan of image/code
Docker Build & Push to ECR	Jenkins agent (with Docker installed)	Builds & pushes Docker image
Kubernetes Deployment	Jenkins agent (with kubectl, awscli, helm, argocd)	Applies manifests to EKS cluster

4️⃣ Agent Configuration (Example in Jenkinsfile):
pipeline {
    agent {
        label 'devops-agent'   // The node label where stages execute
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
    }
}


Or if using Docker agent:

pipeline {
    agent {
        docker {
            image 'node:18'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
}

IQ-Asked-5️⃣ Interview Tip – If They Ask “Where Is Your Agent Hosted?”

You can say:

“Our Jenkins agent runs on an AWS EC2 instance.
The instance has pre-installed tools like Docker, kubectl, Helm, AWS CLI, Trivy, and SonarQube scanner.
We configured it via a Terraform script and connected it to the Jenkins controller using an SSH key.”

(You can also add that you plan to move to Kubernetes-based Jenkins agents for scalability.)

✅ Summary:

The Jenkins master only controls and schedules jobs.
The pipeline stages are executed on the Jenkins agent node, which can be EC2, container, or pod — depending on your setup.



difference between declarative and scripted pipeline.

Declarative pipelines are more structured and easier to maintain, written using a specific syntax that starts with the pipeline {} block. They are ideal for standard CI/CD workflows because they provide features like built-in syntax validation, predefined sections such as agent, stages, steps, and post blocks for success/failure handling.

Scripted pipelines, on the other hand, are fully Groovy-based, so they provide more flexibility and dynamic control. We can use loops, conditionals, and custom logic, but the code becomes harder to read and maintain — so they’re generally used for complex or highly customized pipelines.

For example, in my projects, I prefer Declarative pipelines for most CI/CD jobs like build, test, and deployment to EKS because they’re cleaner and easy to understand for the team. But if I need to add dynamic logic, like conditional environment deployments or looping over multiple microservices, then I use a Scripted block inside a Declarative pipeline using the script {} section.
-------------------------------------------------------------------------------------------------------------
how will you manage credintials in jenkins.where you will store and how will you use?

n Jenkins, I always manage credentials using the Jenkins Credentials Manager, rather than hardcoding them in the pipeline.

All sensitive information like GitHub tokens, AWS access keys, DockerHub credentials, SonarQube tokens, or Kubernetes kubeconfigs are stored securely in Jenkins → Manage Jenkins → Credentials.

Credentials can be stored globally or at the folder level. Depending on the use case, I create credentials of different types — for example:

Username with password (for DockerHub or Git)

Secret text (for API tokens)

SSH key (for Git SSH connections)

AWS credentials (access key ID and secret key)

Once added, I access them in the pipeline using the credentialsId securely.
For example, in a declarative pipeline:

environment {
    AWS_CREDS = credentials('aws-jenkins-creds')
}
stages {
    stage('Login to AWS ECR') {
        steps {
            sh 'aws configure set aws_access_key_id $AWS_CREDS_USR'
            sh 'aws configure set aws_secret_access_key $AWS_CREDS_PSW'
        }
    }
}


Jenkins automatically injects these values as environment variables (_USR, _PSW, _TOKEN), so we don’t expose them in plain text.

Additionally, for higher security, I use:

Folder-level credentials for team isolation

Role-Based Access Control (RBAC) to restrict who can view or edit credentials

And in some cases, integration with HashiCorp Vault plugin to fetch secrets dynamically rather than storing them directly in Jenkins.

So, in short, credentials are stored securely in the Jenkins credential store and used via IDs in the pipeline — ensuring they never appear in the source code or logs.
---------------------------------------------------------------------------------
IQ-Asked-we need to build the 2 jobs in jenkins what syntax will you used for that ?

"In Jenkins, if I want to build two different jobs within a pipeline, I can use the build step in a Declarative or Scripted pipeline depending on the structure.

For example, in a Declarative Pipeline, I’ll use something like this:"

pipeline {
    agent any

    stages {
        stage('Build Job 1') {
            steps {
                build job: 'job1'
            }
        }
        stage('Build Job 2') {
            steps {
                build job: 'job2'
            }
        }
    }
}


If both jobs need to be triggered in parallel, I can define them like this:

pipeline {
    agent any

    stages {
        stage('Parallel Jobs') {
            parallel {
                stage('Job 1') {
                    steps {
                        build job: 'job1'
                    }
                }
                stage('Job 2') {
                    steps {
                        build job: 'job2'
                    }
                }
            }
        }
    }
}

💡 How I explain it practically:

“In our real CI/CD pipeline, sometimes we have microservices or dependent jobs.
I use the build step to trigger other Jenkins jobs and even pass parameters if required.
For example, when a shared library or base image build finishes, the next job automatically starts using this build trigger.”

✅ Key points to mention to interviewer:

You use build job: syntax to trigger another job.

Can trigger sequentially or in parallel.

Can pass parameters using parameters: block if needed.

Useful for microservice or multi-stage dependent builds.


-----------------------------------------------------------------------------------------------
IQ-Asked-difference between normal ec2 instance and lambda fucntion?
 
"Both EC2 and Lambda are compute services in AWS, but they work in very different ways."

⚙️ 1️⃣ EC2 (Elastic Compute Cloud):

It’s a virtual server running in the cloud.

You have full control over the OS, runtime, and installed software.

You need to manage everything — provisioning, scaling, patching, and monitoring.

It’s suitable for long-running workloads like web servers, Jenkins masters, databases, etc.

🧠 Example I use:

In our Jenkins setup, our build agents or master nodes are EC2 instances. We install tools like Docker, Terraform, kubectl manually or via automation.

⚙️ 2️⃣ Lambda Function (Serverless):

AWS Lambda is a serverless compute service — you just upload your code (Python, Node.js, Java, etc.), and AWS runs it.

No server management — AWS handles scaling, patching, and provisioning automatically.

Pay only for execution time, not for idle time.

Best suited for short-running, event-driven tasks like S3 triggers, API Gateway requests, or automation scripts.

🧠 Example I use:

I used Lambda to automate cleanup tasks — for example, automatically deleting old ECR images or unused EC2 snapshots using Python boto3 scripts.

⚖️ 3️⃣ Key Differences Table:
Feature	EC2 Instance	Lambda Function
Type	Virtual Server	Serverless Function
Management	Fully managed by user	Managed by AWS
Scalability	Manual or Auto Scaling	Automatic
Billing	Pay per hour/second (uptime)	Pay per request + execution time
Use Case	Long-running workloads	Event-driven, short tasks
Startup Time	Always-on	Cold start (when invoked)
🧩 4️⃣ Summary (How to End Answer):

“So in short, EC2 gives me flexibility and control, but I have to manage it myself.
Lambda is completely managed and cost-efficient for lightweight automation or microservices, but not suitable for long-running processes.”


-------------------------------------------------------------------

IQ-Asked-What branching strategy will you use in CI/CD? How do you handle releases of the application?

In our CI/CD setup, we follow a branching strategy that ensures proper separation between development, testing, and production code. The most effective one I’ve used is the Gitflow branching strategy.

We maintain a main branch for production-ready code and a develop branch for ongoing integration. Developers work on feature/* branches for new features or bug fixes, and once the work is complete, they raise a pull request to merge into develop.

When we’re ready for a release, we create a release/* branch from develop to perform final validation, testing, and bug fixes. Once QA approves it, the code is merged into main, which triggers a production deployment pipeline in Jenkins. We also tag the release version, for example, v1.3.0, for traceability.

For emergency production fixes, we create a hotfix/* branch directly from main, apply the fix, and then merge it back to both main and develop to keep branches in sync.

In terms of CI/CD, Jenkins automatically triggers builds and tests on feature and develop branches, and when code is merged into main, it triggers deployment to the production environment (like EKS via Helm or ArgoCD).

This approach helps us maintain clean code flow, enables parallel development, supports versioned releases, and provides full traceability with minimal risk during deployment.

✅ Short summary version (if you need to answer quickly):

“We use Gitflow — main for production, develop for integration, feature/release/hotfix branches for work. Jenkins triggers CI/CD pipelines per branch: develop for staging, main for production. Releases are tagged version-wise and deployed automatically. This keeps our release process organized and predictable.”

---------------------------------------------------------------------------------------

IQ-Asked-what branching strategy will you use in cicd? how do releases of application

Code Checkout & Workspace Setup

Build and Test Stage

Nexus (Artifact storage)

Code Quality: SonarQube Integration

Security Scan: Trivy

Build and Push Docker Image to AWS ECR

Cleanup Artifacts

Trigger CD Pipeline

Clone GitOps Repo

Update Image Tag in values.yaml

Commit & Push Change to Git

ArgoCD Automatically Syncs the Change

🔹 When You Clone from the main Branch

When Jenkins starts the pipeline, it checks out the source code from a Git repository — in your case, from the main branch.

So yes, the pipeline runs in a Jenkins workspace created for that main branch.
All stages (Build, SonarQube, Trivy, Docker, etc.) will execute within that workspace, using the code pulled from the main branch at that specific commit (or tag).

🔹 Technical Flow (Step-by-Step Explanation)
1️⃣ Code Checkout & Workspace Setup

Jenkins pulls code from the main branch into its workspace (/var/lib/jenkins/workspace/<job-name>).

From this point, all pipeline stages will operate on this checked-out code.

Jenkins sets environment variables like WORKSPACE, GIT_COMMIT, and BRANCH_NAME.

2️⃣ Build, Test, and Quality Stages

Jenkins runs build commands (e.g., npm install, mvn package, etc.).

Runs unit tests if configured.

Sends code to SonarQube for static analysis.

Runs Trivy scan for vulnerabilities.

All these stages run locally inside Jenkins using the code from the main branch workspace.

3️⃣ Nexus (optional)

If you are packaging an artifact (e.g., .jar or .war), Jenkins uploads it to Nexus.

This stage ensures artifact versioning before containerization.

4️⃣ Docker Build and Push to AWS ECR

Jenkins builds a Docker image from the same codebase.

Tags the image using the build number or Git commit ID (for traceability).
Example:

docker build -t myapp:${BUILD_NUMBER} .
docker tag myapp:${BUILD_NUMBER} <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/myapp:${BUILD_NUMBER}
docker push <aws_account_id>.dkr.ecr.us-east-1.amazonaws.com/myapp:${BUILD_NUMBER}


Image is now stored in AWS ECR for deployment.

5️⃣ Cleanup

Jenkins removes temporary files or old Docker images to save disk space.

6️⃣ Trigger CD Pipeline (GitOps + ArgoCD Flow)

Once the image is successfully pushed to ECR, Jenkins clones the GitOps repository (which contains your Helm charts or Kubernetes manifests).

It then updates the image tag inside the values.yaml file with the new tag (example: image: myapp:23).

Jenkins commits and pushes this change back to the GitOps repo main branch.

7️⃣ ArgoCD Auto-Sync

ArgoCD is continuously watching the GitOps repository.

When it detects the new image tag in the repo, it automatically syncs the Kubernetes environment.

This deploys the new Docker image to your EKS cluster (or whichever cluster you’re using).

🔹 So, Does Everything Happen on main?

Yes — the CI pipeline stages (checkout, build, test, quality, scan, image build) happen in Jenkins workspace cloned from main.

The CD process (GitOps update + ArgoCD sync) happens via a separate GitOps repository, which also typically uses the main branch (production manifests).

💬 Interview-Ready Explanation (How You Should Answer)

Our Jenkins pipeline is triggered from the main branch, meaning the code checkout and all CI stages—build, test, SonarQube analysis, Trivy scan, and Docker image creation—are executed using the code from that branch. Jenkins creates a clean workspace where all these stages run sequentially.

Once the Docker image is built and pushed to AWS ECR, the pipeline moves to the CD phase. Jenkins then clones the GitOps repository, updates the image tag in the values.yaml file, commits, and pushes the change to the main branch of the GitOps repo.

ArgoCD, which continuously monitors that repository, detects the new image tag and automatically syncs the deployment to the Kubernetes cluster.

So, to summarize — all CI stages run on the main branch workspace in Jenkins, and the deployment is handled automatically by ArgoCD through GitOps once the new image tag is committed.

-------------------------------------------------------------------------------------------------
IQ-Asked-tell me the difference between docker create and docker run?

The main difference between docker create and docker run is that docker create only creates a container, while docker run creates and starts the container immediately.

🔹 1. docker create

It creates a container from an image, but does not start it.

The container will be in the created state.

Useful when you want to customize or inspect the container before running it.

Example:

docker create --name myapp nginx


This command just creates the container — it doesn’t run Nginx.
You can check it with:

docker ps -a



Then you can manually start it:

docker start myapp

🔹 2. docker run

It’s a combination of docker create + docker start.

It creates the container and immediately starts it.

Most commonly used command to start a new container.

Example:

docker run --name myapp -d nginx


This both creates and runs the container in detached mode (-d).

🔹 3. Key Difference Summary
Feature	docker create	docker run
Creates container	✅	✅
Starts container	❌	✅
Common use case	When you want to modify or inspect before starting	When you want to create and start immediately
Typical workflow	create → start	run (both in one step)
🔹 4. Real-Time Example (for 5 years experience)

In one of my CI/CD setups, I used docker create when I wanted to pre-create containers with environment variables and volume mounts, but start them later during the test execution phase.
However, for normal builds and application deployments, we use docker run in the Jenkins pipeline since it’s faster and handles both creation and startup automatically.

✅ In short:

"docker create prepares the container; docker run prepares and starts it."



------------------------------------------------------------------------------------------------------------
IQ-Asked-i need to delete some image and container thats status is unused how will you do it

To clean up unused Docker containers, images, and other artifacts, I use Docker’s built-in pruning commands.
I first identify what’s unused, verify it, and then safely remove it using docker container prune, docker image prune, or the all-in-one docker system prune.

🔹 1. Check Current Resources

Before deleting anything, always list what’s currently running or available:

docker ps -a        # shows all containers (running + stopped)
docker images -a    # lists all images

🔹 2. Remove Unused Containers

Containers in the exited or created state can be removed safely:

docker container prune


👉 This deletes all stopped containers.
You’ll be prompted for confirmation — use -f to skip it:

docker container prune -f

🔹 3. Remove Unused Images

To remove dangling or untagged images (not referenced by any container):

docker image prune


If you want to remove all unused images (not just dangling ones):

docker image prune -a


⚠️ Be careful with -a — it will delete all images not used by any container.

🔹 4. Remove Everything Unused (One-Shot Clean-Up)

For full cleanup — unused containers, images, networks, and build cache:

docker system prune


Or to include unused volumes as well:

docker system prune -a --volumes

🔹 5. Example (Real-Time Scenario)

In Jenkins build servers, multiple builds create temporary images and containers.
We schedule a weekly cleanup job using:

docker system prune -a -f


This ensures old build images, intermediate layers, and stopped containers are removed, freeing up disk space automatically.

🔹 6. Optional: Delete Specific Container or Image
docker rm <container_id>
docker rmi <image_id>


If you want to force delete:

docker rm -f <container_id>
docker rmi -f <image_id>


✅ In short (summary line for interviewer):

“I use docker system prune -a to clean up all unused Docker resources safely, and also automate it via a cron job or Jenkins maintenance job to keep the environment clean.”

----------------------------------------------------------------------------------------------------
IQ-Asked-we have created one feature branch on github i need to delete that feature brach from command line what command will you use?

1️⃣ Delete the branch locally
git branch -d feature/<branch-name>


-d → safe delete (Git will prevent deletion if branch is not merged).

-D → force delete (even if branch is not merged).

Example:

git branch -d feature/login-page

2️⃣ Delete the branch remotely
git push origin --delete feature/<branch-name>


Example:

git push origin --delete feature/login-page


This removes the branch from the GitHub remote repository.

✅ Summary
Action	Command
Delete local branch safely	git branch -d <branch>
Force delete local branch	git branch -D <branch>
Delete remote branch	git push origin --delete <branch>

💡 Interview Tip:
You can also mention that deleting feature branches after merging keeps the repository clean and avoids clutter.

-------------------------------------------------------------------------------------------

IQ-Asked-HOW DO you manage enforce previledge access in IAM in aws

In AWS, enforcing least privilege access is critical for security and compliance. I manage and enforce privilege access in IAM using a combination of policies, roles, groups, and monitoring tools.

🔹 1️⃣ Use IAM Policies (Least Privilege Principle)

I create fine-grained policies that grant only the permissions required for a user or service.

Avoid using AdministratorAccess unless absolutely necessary.

Example: If a developer needs S3 read/write access for a specific bucket:

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": ["s3:GetObject", "s3:PutObject"],
            "Resource": ["arn:aws:s3:::my-app-bucket/*"]
        }
    ]
}

🔹 2️⃣ Use IAM Groups and Roles

Assign users to groups based on job functions (Dev, QA, Admin) and attach policies at the group level.

Use IAM roles for EC2, Lambda, or other services instead of embedding credentials.

Roles can be assumed temporarily, which reduces long-term credential exposure.

🔹 3️⃣ Enforce MFA (Multi-Factor Authentication)

Require MFA for all privileged users (especially admin accounts).

You can enforce it via IAM policies:

"Condition": {
  "Bool": {"aws:MultiFactorAuthPresent": true}
}

🔹 4️⃣ Use Permission Boundaries

For users with administrative privileges, I apply permission boundaries to restrict them from creating overly permissive policies.

🔹 5️⃣ Enable Monitoring & Alerts

Enable AWS CloudTrail to log all API calls.

Use AWS Config rules or IAM Access Analyzer to detect unused or excessive permissions.

Regularly review IAM roles and policies for over-permission.

🔹 6️⃣ Temporary Credentials

Use STS (Security Token Service) to issue temporary credentials with time-limited access for sensitive operations.

🔹 Summary Line for Interviews

“In short, I enforce privilege access in AWS IAM by following the least privilege principle, using fine-grained policies, groups and roles, MFA, permission boundaries, and continuously monitoring using CloudTrail, IAM Access Analyzer, and AWS Config.”

💡 Pro Tip for Interviews:
If asked, you can also give an example from your project:

“In my last project, we had a CI/CD pipeline where EC2 instances assumed a role to push Docker images to ECR. The role had only ecr:PutImage and ecr:InitiateLayerUpload permissions, nothing else. This ensures that even if credentials were compromised, access was limited.”

----------------------------------------------------------------------------------
IQ-Asked-how would you secure s3 bucket that store sensitive data

To secure an S3 bucket that stores sensitive data, I follow multiple layers of security: access control, encryption, monitoring, and compliance.

🔹 1️⃣ Access Control

Use IAM policies and bucket policies to restrict access to only authorized users, groups, or roles.

Avoid using * (public) access.

Example bucket policy:

{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": ["arn:aws:s3:::my-sensitive-bucket", "arn:aws:s3:::my-sensitive-bucket/*"],
      "Condition": {"Bool": {"aws:SecureTransport": false}}
    }
  ]
}


This denies all non-HTTPS requests.

Enable block public access on the bucket.

🔹 2️⃣ Encryption

Server-Side Encryption (SSE):

SSE-S3: AWS managed keys

SSE-KMS: AWS KMS managed keys for better audit & control

Client-Side Encryption if needed, before uploading sensitive data.

aws s3 cp secret.txt s3://my-sensitive-bucket/ --sse aws:kms --sse-kms-key-id <KMS_KEY_ID>

🔹 3️⃣ Versioning & MFA Delete

Enable versioning to protect against accidental deletion.

Enable MFA Delete for extra security when deleting objects.

🔹 4️⃣ Logging and Monitoring

Enable S3 server access logs to track access requests.

Integrate with CloudTrail for API-level monitoring.

Set up CloudWatch alarms for unusual access patterns.

🔹 5️⃣ Network-Level Security

Use VPC endpoints to access S3 privately without going through the public internet.

Use bucket policies to restrict access to specific VPCs or IP ranges.

🔹 6️⃣ Lifecycle & Backup

Define lifecycle policies to archive or delete old data securely (e.g., move to Glacier).

Regular backups or replication across regions for disaster recovery.

🔹 7️⃣ Summary Line for Interview

“In short, I secure sensitive S3 buckets by enforcing least privilege access via IAM and bucket policies, encrypting data at rest and in transit, enabling versioning with MFA delete, monitoring access via CloudTrail and CloudWatch, and using VPC endpoints to restrict network access.”

💡 Pro Tip:
If asked for a real-world example, you can say:

“In my last project, we stored confidential reports in S3 with SSE-KMS encryption, blocked all public access, allowed only CI/CD pipelines via specific IAM roles, and monitored access via CloudTrail and CloudWatch for anomalies.”

-----------------------------------------------------------------------------------------------------
IQ-Asked-difference between git reset and git revert?

Both git reset and git revert are used to undo changes in Git, but they work differently and are used in different scenarios.

🔹 1️⃣ git reset

Purpose: Moves the HEAD to a specific commit, optionally changing the index (staging area) and working directory.

Effect: Can rewrite history — dangerous on public/shared branches.

Use Case: Used locally to undo commits that haven’t been pushed.

Example:

# Soft reset – keeps changes in staging
git reset --soft HEAD~1

# Mixed reset – keeps changes in working directory, unstaged
git reset --mixed HEAD~1

# Hard reset – discards changes completely
git reset --hard HEAD~1


⚠️ git reset rewrites history, so it should not be used on branches shared with others.

🔹 2️⃣ git revert

Purpose: Creates a new commit that undoes the changes of a previous commit.

Effect: Does not rewrite history — safe for public/shared branches.

Use Case: Used to undo changes that have already been pushed, without affecting other developers.

Example:

# Revert a specific commit
git revert <commit-hash>


This generates a new commit that reverses the changes introduced by <commit-hash>.



In one of my projects, a developer accidentally pushed a commit with sensitive info. Since it was already on the remote branch, I used git revert <commit> to safely undo it without rewriting history.
For local experimental commits that were not pushed, I often use git reset --hard to clean up my working directory and start fresh.

✅ Short Interview Line:

“git reset rewrites commit history and is mainly used locally, while git revert safely undoes changes by creating a new commit and is safe on shared branches.

------------------------------------------------------------------------------

IQ-Asked-one microservice is failing because of resource constraint issue so how will you increase resource and memory?

✅ Interview-style answer (confident & concise):
“If a microservice is failing due to resource constraints, I would first identify whether it’s CPU or memory related by checking metrics in Prometheus or kubectl describe pod for OOMKilled or throttling events. Once confirmed, I’d update the Deployment manifest to increase the resource requests and limits under the resources section — for example, increasing CPU from 200m to 500m or memory from 256Mi to 512Mi. After updating, I’d redeploy the pod and monitor it again to ensure stability.”

🧠 Explanation (for your understanding & follow-ups):

1. Identify the issue:

Check pod status:

kubectl describe pod <pod-name> | grep -A5 "Containers:"


Look for OOMKilled (memory issue) or CPU throttling (CPU issue).

You can also check metrics in Prometheus, Grafana, or kubectl top pods.

2. Modify resource configuration (Deployment YAML):

resources:
  requests:
    cpu: "500m"
    memory: "512Mi"
  limits:
    cpu: "1"
    memory: "1Gi"


3. Apply changes:

kubectl apply -f deployment.yaml


4. Verify new resource allocation:

kubectl describe pod <pod-name> | grep -A5 "Limits"


5. Monitor post-deployment:
Use kubectl top pods or Grafana dashboards to confirm the microservice runs within the new limits.

--------------------------------------------------------------------------------

IQ-Asked-What is the Self-Heal Feature in Argo CD?

Self-heal in Argo CD means that Argo CD automatically detects and corrects any drift between the desired configuration (stored in Git) and the actual state running in the Kubernetes cluster.

🔍 Detailed Explanation

Argo CD continuously monitors the live Kubernetes resources and compares them with what’s defined in the Git repository.

If someone manually changes or deletes something in the cluster (for example, using kubectl edit or kubectl delete), Argo CD detects that drift.

If self-heal is enabled, Argo CD will automatically revert the cluster to match the Git-defined configuration.

So the cluster always stays in GitOps desired state — even if a manual change happens.

⚙️ How it Works Internally

Every few seconds, Argo CD performs a diff between:

Live state (actual cluster resources)

Desired state (Git manifest)

If a difference (drift) is found:

With Auto-Sync + Self-Heal ON, Argo CD applies the Git manifest again automatically.

Without Self-Heal, it only marks the app as OutOfSync, and you must sync manually.

✅ Example

Imagine you deployed a Deployment from Git that runs 3 replicas.

Someone manually scales it down to 1 replica in the cluster.

Argo CD detects this change.

If self-heal is enabled, it will automatically scale back to 3 replicas — as per Git.

🧠 How to Enable Self-Heal

In the Argo CD UI or Application manifest, set:

spec:
  syncPolicy:
    automated:
      prune: true
      selfHeal: true


prune: true → delete resources not in Git

selfHeal: true → revert any drift automatically

💬 Interview-Ready Short Answer

“Self-heal in Argo CD ensures that the actual state of the Kubernetes cluster always matches the desired Git state. If someone manually changes or deletes a resource, Argo CD automatically detects and corrects it. This is enabled using syncPolicy.automated.selfHeal: true in the Application spec.”

--------------------------------------------------------
IQ-Asked-what is the difference between vpc peering and aws private link?

So both VPC Peering and AWS PrivateLink are used to connect VPCs privately without exposing traffic over the public internet, but the way they work and their use cases are quite different.”

🔹 VPC Peering – Explanation

“VPC Peering is basically a network-level connection between two VPCs. It allows full two-way communication — instances in both VPCs can talk to each other using private IPs — just like they’re on the same network.
It uses the AWS backbone network, so traffic doesn’t go through the public internet.”

Key points:

It’s point-to-point — each peering connection links two VPCs.

Transitive peering is not supported — if VPC-A is peered with VPC-B, and B is peered with C, A can’t talk to C.

You must manage route tables and security groups manually to allow communication.

Suitable when you want full bidirectional connectivity between networks — for example, connecting multiple environments like dev ↔ prod, accounts ↔ shared services, etc.

Example:

“In my previous project, we used VPC peering between our application VPC and monitoring VPC to send metrics directly to Prometheus without internet exposure.”

🔹 AWS PrivateLink – Explanation

“PrivateLink, on the other hand, is service-level connectivity. It’s used when one VPC wants to privately access a specific service (like an API or application) hosted in another VPC or AWS service, without exposing the entire VPC.”

How it works:

The service provider creates a VPC endpoint service.

The consumer creates an Interface Endpoint (ENI) in their VPC that connects to that service privately.

Traffic stays on the AWS private network.

Unlike peering, communication is one-way — the consumer accesses the provider’s service, not the entire VPC.

Example:

“We used PrivateLink to allow our internal services in one account to access an API Gateway endpoint hosted in another account securely through private IPs — without opening up full VPC access.”

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Terraform interview questions:-

Q) How do you connect Terraform with AWS?
--> we connected terraform with aws cloud using aws provider block in configuration file. this will help us
  to create, update, and delete aws resources. we connected terraform with aws with proper authentication 
and configuration so terraform can interact with aws api.-- we need to configure aws.

Q) What is the difference between count and for_each in Terraform?
 - both are used to create multiple resources. count is index based and works well for identical resources,
   but can lead to accidental destruction if the list changes.
   for_each is key based and works with maps or sets, providing more stable and predictable management of resources.

 
resource "aws_instance" "web" {                                   resource "aws_instance" "web" {
   count  = length(var.instance_types)                               for_each = var.instances
   ami    = "ami-6f7egfj"                                            ami = "ami-o66nccyyfhf"
   instance_types = var.instance_types[count.index]                  instance_type = each.value
   tags = {                                                          tags = {
     Name = "web-${count.index}                                      Name = each.key

variable "instance_types"                                         variable "instances" {
    default = ["t2.micro", "t2.small", "t2.medium"]               default = {
                                                                     "frontend" = "t2.micro"
                                                                      "backend" = "t2.small"
                                                                      "database" = "t2.medium"


count = length(var.instance --> create 3 instances                  create 2 instances frontend and backend       instance_types = var.instance_types[count.index]-                   can access instance with                  
   assign unique type to each instance.                               aws_instance.web["frontend"]                   aws_instance.web[0] --> t2.micro                                   aws_instance.web["back end"]
  aws_instance.web[1] --> t2.small
  aws_instance.web[2] --> t2.medium

----------------------------------------------------------------------------------
Q) What types of conditional expressions have you used in Terraform?
   conditional expressions used in terraform to dynamically decide values during execution.
   its used to control resource creation, assign variable values, and handle environment based configuration.
   
   resource "aws_instance" "web" {
   ami  = "ami-h6s8k5b6"
   instance_type = var.environment == "prod"  ? "t3.large" : "t2.micro"

   variable "environment" {
     default ="dev"
    }

      if environment is prod then t3.large instance will be used otherwise t2.micro.

-------------------------------------------------------------------------------
If you’ve created a VPC and subnets manually in AWS, how can you create an EC2 instance inside those existing resources using Terraform?
-->we used terraform data sources to dynamically fetch existing aws resouces.
   
   data "aws_vpc" "existing_vpc" {
      filter {
        name = "tag:name"
        values = ["my-existing-vpc"]
      }
     }
    data "aws_subnet" "existing_subnet" {
      filter {
        name = "tag:name"
        values = ["my-public-subnet"]
       }
      }
    resource "aws_instance" "my-ec2" {
    ami        =  "ami-h7ks5kdu"
    instance_type  = "t2.micro"
    subnet_id  = data.aws_subnet.existing_subnet.id
    tags = {
      Name = "EC2-in-existing-vpc"
     }
    }
data block read existing resources from AWS.
   This is best practice when integrating new terraform code with existing setup.



----------------------------------------------------------------------------
whenever a resource exist outside of terraform - meaning it was created manually or by another team - and i want to create new resources that depends on it i use data block, data block allows terraform to read attribute of existing resources (ID,ARN,tags) so i can safely reference it in my new resources without trying to recreate or manage it. 
data "aws_s3_bucket" "existing_bucket" {
  bucket = "manuallycreated05"
}

terraform init
terraform plan

data sources are read only and and not tracked in state file. but we can create new resource that depends on these data sources.
----------------------------------------------------------------------------------

Whenever a resource exist outside of terraform we fetch it using terraform import.
  we need to write resource block first for s3 bucket. 
      resource "aws_s3_bucket" "existing"  {
      bucket = "manuallycreated01"
then we need to use import command -- terraform import aws_s3_bucket.existing manuallycreated01
After import state file(.tfstate) is updated with bucket details.
terraform now manages this bucket.
   Now even after deleted this bucket from UI and again i have run terraform apply then bucket will be created because .tfstate still think bucket exist.

---------------------------------------------------------------------------------------------------------------------------------------

Q) how do you manage state file in terraform?
 --> I always manage state file centrally and securely storing in amazon s3 with versioning enabled and state locking using dynamoDB. 
      this ensures that the state file is not stored locally. so avoid conflicts when multiple team members apply terraform and maintains versining if rollback is needed.
    I also enable s3 bucket versioning and encryption(SSE-S3,KMS) to protect sensitive data present inside state file.
    In dynamoDb table i use specific lock ID that prevents two users from appying changes at the same time.
    additionally i restrict access to the s3 bucket and dyanodb using IAM policies , so only cicd pipeline or authorized users  can access or modify state file.

------------------------------------------------------
Q) What happens to terraform when someone changes infra manually from AWS console?
   When someone changes infrastructure manually from the AWS console, Terraform is not automatically aware of those changes.
Terraform’s understanding of the infrastructure is based on its state file, and that state may now be out of sync with the real resources in AWS — this is called drift.

To detect these changes, we can run terraform plan or terraform refresh. These commands compare the actual infrastructure with what’s recorded in the state file.

If drift is detected, Terraform will show the differences in the plan. Then, during terraform apply, it will try to bring the infrastructure back in line with the configuration defined in the .tf files — either by modifying or recreating the resources.

To avoid such issues, I always recommend making changes only through Terraform and not directly in the console.”
  
terraform refresh - will update the state file with new changes as per real infrastructre.
terraform plan - command will show drift and plan to change it back.

“If an EC2 instance type was changed manually from t2.micro to t3.micro, running terraform refresh will update the state file to show t3.micro.
But the Terraform configuration (.tf file) still has t2.micro, so during the next terraform plan, Terraform will show a drift and plan to change it back to t2.micro.”



-----------------------------------------------------------------------------------------------------------------------------------------------------------------

AWS interview questions :-

-----------------------------------------------------------------------------------------------------------------------------------------------------------
Q) what is the difference between public and private key?
   public and private keys are part of asymmetric encryption. -both work as pair- public key used to encrypts data and private key used to descrypt it.
  we can share public key to others , they can use it to send encrypted data then i will decrypt it using private key.
we connect ec2 instance via SSH using private key(.pem) and stores public key on instance.
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Q) Why you won’t go with EC2 for installing a Database? Why RDS?

when we install DB on ec2 then we are responsible for everything below
Installing and maintaining the DB software
backup of database
high availability setting to DB
performence patching and version upgrade
and managing failover during downtime

on other side AWS RDS automated all these administrative task
it handles automatic backup, patching, and monitoring
it supports multi-AZ depployments for high availabililty and automatic failver
it provides read-replicas for scaling read traffic
performence insights and cloudwatch integration helps in monitoring and tunning.
with automated snapshot and restore points disaster recovery becomes much easier.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Q) 





----------------------------------------------------------------------------------------------------------------------------------------------------------------
You have a private subnet with no internet access, but your instances need to download updates. How do you enable this securely?
--> By default private subnet is not having internet access. to enable internet access to private subnet we need to have NAT gateway.
   NAT gateway is used to provide internet access to private subnet. NAT gateway is having pulic IP so we placed it into public subnet.we need to modify
   private route table with mentioning NAT GW ID.
   destination: 0.0.0.0 -> Target NAT Gateway ID
   so private instances are able to download packages from internet through NAT GW and responses are routed back securely.
     This allows inbound internet traffic (for package update, )  but blocks any inbound connection from the internet.
            worker nodes are placed in private subnet so to download docker images, pull OS update,security patches, we have created NAT GW in public subnet.so instances
            will get internet access.

   If instance only need access to AWS services eg s3 then we create VPC endpoint.
     s3 gateway endpoint, or interface endpoint allows private communications between VPC and AWS services without internet.
    this improves security and reduces NAT data transfer cost.
             with using VPC endpoint jenkins agent will able access s3 and ECR.

--------------------------------------------------------------------------------------------------------------------------------------------------------------------
Interview asked - How public and private subnets instances communicated in same VPC?
 
In AWS, communication between instances inside the same VPC happens through private IP addresses using VPC’s internal routing.

Since both my public and private subnets belong to the same VPC and are connected via the VPC’s main route table, they can communicate directly using private IPs — even though one subnet is public and the other is private.

The only difference between public and private subnets is their route table configuration:

Public subnets have a route to the Internet Gateway (IGW).

Private subnets do not have a direct route to the IGW.

But inside the VPC, private-to-public or public-to-private communication works over the internal AWS network without using the Internet Gateway — it’s local routing.”   
------------------------------------------------------------------------------------------------------------------------------------------------------------------
If there are two S3 buckets Bucket A (source) and Bucket B (destination) and a file in Bucket A is accidentally deleted, what happens in Bucket B.

If a file in Bucket A (the source) is accidentally deleted, what happens in Bucket B (the destination) depends on how the S3 replication rule was configured.

By default, S3 Cross-Region Replication (CRR) or Same-Region Replication (SRR) only replicates new objects and updates, not deletions.
So, if I delete an object in Bucket A, it will still remain in Bucket B — the deletion won’t be replicated automatically.

However, if ‘Delete marker replication’ is explicitly enabled in the replication configuration, then the delete marker (for versioned buckets) will also be copied to Bucket B, effectively deleting the file there too.”

---------------------------------------------------------------------------------------------
Q) What is a Static IP and a Public IP?
A Public IP is an IP address that is accessible over the internet.
It’s assigned to resources like EC2 instances, load balancers, or NAT gateways so they can communicate with external networks.

A Static IP means an IP address that does not change — it remains permanently assigned to the resource.
In AWS, a static public IP is called an Elastic IP (EIP). Even if the instance is stopped or restarted, the Elastic IP stays the same.

In contrast, a dynamic public IP (default behavior) changes whenever the instance is stopped and started again.”

----------------------------------------------------
Q) What is the difference between a Security Group and a Network ACL (NACL)?

“A Security Group and a Network ACL (NACL) both control traffic in a VPC, but they work at different layers and serve different purposes.

A Security Group acts as a virtual firewall for EC2 instances — it controls inbound and outbound traffic at the instance level.
It is stateful, meaning if you allow inbound traffic, the response is automatically allowed out, even if there’s no explicit outbound rule.

A Network ACL (NACL), on the other hand, operates at the subnet level.
It controls traffic entering or leaving an entire subnet and is stateless, which means return traffic must be explicitly allowed by separate rules.”
------------------------------------------------------------------------
How do you create S3 Cross-Region Replication (CRR)?

“S3 Cross-Region Replication (CRR) is used to automatically replicate objects from a source bucket in one AWS region to a destination bucket in another region.

To create CRR, these are the main steps:

Enable versioning on both source and destination buckets — replication only works with versioned buckets.

Create an IAM role that grants S3 permission to replicate objects on your behalf.

Configure a replication rule on the source bucket:

Specify the destination bucket and region

Choose which objects to replicate (all objects or objects with a specific prefix or tag)

Optionally enable replication of delete markers.

Save the replication configuration — S3 automatically starts replicating objects to the destination bucket.”
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
kubernetes interview questions :-

finalizers:-
 finalizers is metadata field in k8 resource that prevents the objects from being deleted until certein cleanup actions are performed.
   when we apply finaliers on any resource and we delete it then k8 marks it for deletion(add deletionTimestamp) but the resource stays in cluster until all its finalizers are removed.
finalizers are used to ensure graceful cleanup of external resources before  the k8 object is premanently deleted.

pvc , namespace custom resources, service LoadBalancer we applied finalizers on this resources.


apiVersion: sample.io/v1
kind: Database
metadata:
   name: my-db
   finalizers:
     - sample.io/db-cleanup
spec:
  dbName: testdb

we created Database/my-db --- then custom controller (operator) creates real database named testdb in aws .
so there are two things.
Database/mydb  --> The k8 objects
testdb         --> External actual database instance.

when we apply
kubectl delete Database/my-db --> Then k8 sets deletionTimestamp on Database/my-db Object. k8 sets finalizers  (sample.io/db-cleanup), k8 does not delete it yet.
so controller first delete actual Database instance(testdb)--> once this cleanup is done succesfully the controller removes finalizers.

controller cleanup --> Delete the actual DB instance   --> Outside kubernetes
kubernetes deletion --> deletes the custom resource objects --> inside kubernetes.


















-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Remembering deployment manifiest
apiVersion: apps/v1    --आप
kind: Deployment       --की याद
metadata:              -मिटा
  name: nginx-deployment  --ना  सखे
  labels:               -- लब हमारा
    app: nginx          -- आप
spec:                   --से  है       
  replicas: 3           -रे .
  selector:             -स..
    matchLabels:        -मा...
      app: nginx       --आप
  template:            --मंदिर
    metadata:          --मे मिली
      labels:          -लब
        app: nginx     -आप
    spec:              - से हुआ
      containers:      -कौन सा
      - name: nginx    -नाम दूँ
        image: nginx:latest   तस्वीर 
        ports:    -     पर
        - containerPort: 80 --कौन सा

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Q) Suppose you want to scale the pod through command line , what is the kubernete you use to scale up and run the number of pods

kubectl scale deployment <deployment-name> --replicas=<number-of-pods>
  a)  kubernetes scale command update .spec.replicas field in the deployment.
    kubernetes will automatically create or delete pods to match desired replica count. the scaling operation is handled by deployment controller. ensuring the desired and ctual state match.
   b)  kubectl edit deployment <deployment_name>

   c) we can use horizontal pod autoscaler (HPA) to automatically  scale pods based on CPU and memory utilization.
    kubectl autoscale deployment myapp-deployment --min=2 --max=2 --cpu-percent=80




------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

What is resource quota?
--> A resource quota in k8 is namespace-scoped-object that limits how  much resource (CPU, Memory, number of pod) team or application can consume.
    Resource quote controlled by API server-->when a new resource created, (eg pod,pv ) first API server check if adding these any resource exceeded the quota
    if yes then those resource will not scheduled.
   we used resource-quota together with LimitRange. -LimitRange set per pod limit, ResouceQuota set namespace-wide total.

apiVersion: v1
kind: ResourceQuota
metadata:
 name: team-a-quota
 namespace: team-a
spec:
  hard:
    pods: "10"
    requests.cpu: "4"
    requests.memory: 8Gi
    limits.cpu: "8"
    limits.memory: 16Gi
    persistentvolumeClaim: "5"
    services: "3"

Important commands:-
kubectl get resourcequota -n dev -a                              --list quotas in namesoaces
kubectl  describe resourcequota team-a-quota -n team -a          --show detailed usage and hard limits
kubectl apply -f quota.yaml                                      -- apply quota
kubectl delete resourcequota team-a-quota -n team -a             -- delete quota
kubectl get resourcequota --all-namespace                        --view all quotas cluster wide


In namespace we specified resourcequota and resource request and limit and if we created deployment with resourcequota mentioned but not mentioned resource request and limit then api server reject this request.
    

--------------------------------------------------------------------------------------------------------------------------------------------------------------
How do you troubleshoot networking issues?

kubectl get pods -o wide   --- First we will check status of pod and on which node they are running.
kubectl exec -it <pod> -- bash - Then i will login pod and check connectivity isse ping , curl, nslookup. if the pod cannot communicated with other service , i test
                                 service name resolution to confirm DNS works - nslookup servicename.namespace.svc.cluster.local

Then i will check whether the service has correct selector and port mapping using below command.
kubectl get svc  ,   kubectl describe svc <service-name>

Then i will check endpoint of service, if endpoints are not showing means pods are not correctly matched with service selector.
kubectl get endpoints <service-name>

If policies are enabled then i will check if policies are blocking traffic between namespaces or pods. sometimes one namespace is restricted from communicating with 
another which causes connectiion timeouts.
Then i will check CNI plugin status.--var/log/aws-routes-eni or kubectl -n kube-system <cni-pod>  to ensure network daemonset is healthy,
i also make sure that pod IPs are from right subnet  ranges defined in the vpc .
if specific node is having networking issue , then i do ssh and check system-level networking like ip route , ipconfig, or iptables -L
sometimes security group or NACL at the aws level block inter-node communication.
External access issue-
if traffic from outside cant reach the service , i validate the ingress, /load balancer configuration and the target group health in aws console.
I also ensure the security group rules and network ACLs allow traffic on the correct ports.









---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

what are the prerequisite before creating EKS cluster?

--> several AWS resources and k8 configurations need to be defined before the cluster becomes functional.
    below are prequisite
   A) VPC with required public and private subnet.
   B) IAM role for EKS control plane
   C) Security groups
   D) Subnets tagged properly for kubernetes (EKS used these tags to attach ENIs)
   E) IAM OIDC provider if i plan to integrate IAM role with service account.

   After control plane creation we need to create node group and associate it with the cluster.     
   configure IAM role for node group with amazonEKSWorkerNodePolicy, AmazonEC2ContainerRegistryReadOnly, AmazonEKS_CNI_Policy
   Namespace creation.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
Q) what do you understant by Taint & tolerations?

Taints are applied on nodes to prevent pods from scheduling unless they tolerate the taint.
     toleration are applied to pods so they can run on tainted nodes. this is useful isolating special workload. its way to guide k8s scheduling decisions with more control.

Q) Pod affinity and Node affinity?
  A pod wants to schedule on node which have similar pod with matching label.
        pod Anti-affinity keeps pods apart for high availabililty.
   Node affinity-
  A pod wants to schedule on node which has label defined in pods yaml file.



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

500 - internal server error -  the pod receives the requests , but crashed due to app bug, dependency issue or misconfiguration.
502 - Bad gateway  - when ingress controller /ALB tries to send traffic to pod thats  not ready, crashed, or unhealthy, when liveness probe fail 
503 - service unavailable - when all pods are down , or service has no healthy endpoint 
504 - gateway timeout - when pods get too long to respond.(high latency) 

kubectl get pods -n <namespace>
kubectl describe pod <pod-name>
kubectl logs <pod-name> -n namespace
kubectl get svc <service-name> -n namespace
kubectl describe service <service name>
kubectl get endpoints <service-name>

ensure endpoint exists and point to running pod.
check ingress/ALB-->if any miscofigured target group or health check

for 5** errors these errors are server-side rejections, not client errors- meaning the client request was valid,but the server failed to process it properly.


ver
403 Errors -  

    In this scenario client is authenticated but not authorized to access the resource.
              its server side rejection of the request due to lack of permission.
    IAM or RBAC denying access.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
What are the types of Deployments in Kubernetes?

1. Recreate Deployment

What it does: Deletes all existing Pods first, then creates new ones.

Use case: Simple apps where downtime is acceptable.

2. Rolling Update Deployment (Default)

What it does: Gradually replaces old Pods with new ones without downtime, updating a few at a time.

Use case: Production applications where high availability is critical.

Key parameters: maxUnavailable and maxSurge to control rollout pace.

3. Blue-Green Deployment (via tools like ArgoCD / manual)

What it does: Creates a new set of Pods (green) while keeping the old set (blue) running. Switches traffic to the new set once ready.

Use case: Zero-downtime deployment with easy rollback.

4. Canary Deployment (via tools like Istio / Argo Rollouts)

What it does: Releases the new version to a small subset of users first, monitors it, then gradually rolls out to everyone.

Use case: Testing new versions safely in production.

---------------------------------------------------------------------------------------------
What is a DaemonSet, and how is it used?


A daemonset is monitoring agent placed on each node in kubernetes to collect logs from each node. 
use cases-
Log collection agents - fluentd, logstash - to collect logs from all nodes.
Monitoring agents - prometheus node-exporter - To monitor every node.
Networking /security agent - (calico,cilium) - That must run on each node.

we have used kind: daemonset to create node-exporter pod on every node.and if new node joins a cluster the pod is automatically added there.


------------------------------------------------------------------------------------------------------------------------------


✅ Interview Answer:

“If the Kubernetes nodes are healthy but kubectl logs shows blank logs for critical pods, it usually indicates that the containers in those pods are not writing logs to stdout/stderr.
Kubernetes captures logs from stdout and stderr of the container. If the application writes logs to a file inside the container or a non-standard location, kubectl logs will appear empty.

Other Possible Causes

Pod hasn’t started or crashed

Check with kubectl get pods — if the pod is in CrashLoopBackOff or Init state, logs may be empty.

Sidecar logging issues

If you’re using a logging agent like Fluentd, DaemonSet, or sidecar containers, the main container logs may not be visible if misconfigured.

Incorrect container name in multi-container pods

For pods with multiple containers, you need to specify the container name:

kubectl logs <pod-name> -c <container-name>


Log rotation or ephemeral logs

If the container restarted quickly, logs from previous instances may be lost. Use --previous to see logs of previous containers:

kubectl logs <pod-name> --previous

💡 Interview Tip / Senior-Level Insight

“I would first check the pod status with kubectl describe pod <pod-name> to see if it’s crashing, and confirm the application logging configuration.
It’s a common mistake in production — many apps write logs to files inside the container, which requires either sidecar file log collection or reconfiguring the app to write to stdout/stder
 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
GIT interview questions:-

Interview-Asked --what is GIT stash?
 Git stash command is used to temorarily save uncommitted changes without committing them to branch.
 suppose i am working on feature branch and suddenly i need to switch on another branch then i can use git stash
  to save my current modifications.
 after finishing work from another branch then i will back to the feature branch and save changes using git stash pop and git stash apply.
--> This helps to avoid unneccesary commits and keeps the branches clean.

# we have some uncommited changes--git status
# temporarily saved.            --git stash
# switch to another branch      --  git checkout main
# fix something, commit, and then go back  -- git checkout feature/new-api
# restore the stashed changes   -- git stash pop


git stash list -- To view all stashed entries
git stash drop -- To delete specific tashes.

---------------------------------------------------------------------------------------------------

Q) I have made changes on remote repo but i want to rollback as per local repo how will you do it?

git push origin master --force

---------------------------------------------------------------------------------------------------------------------------------------------

1️⃣ What is Git and why do we use it?

Answer:
Git is a distributed version control system that tracks changes in source code. It allows multiple developers to collaborate, maintain version history, and revert to previous versions.
In DevOps, Git is crucial for CI/CD pipelines, Infrastructure as Code (IaC), and collaboration.

2️⃣ How do you check the current status of your Git repository?

Command: -- git status

shows staged, unstaged, untracked files - helps you know whats ready to be commited.

5️⃣ How do you add files to staging area?

git add <filename>
git add .
moves modified or new files to staging area before committing.

6️⃣ How do you commit changes?

Command:

git commit -m "Added Jenkinsfile for CI/CD"


Explanation:
Creates a new commit (version snapshot) with a message.

7️⃣ How do you push your code to a remote repository?

Command:

git push origin main


Explanation:
Uploads local commits to a remote branch (main, develop, etc.).



8️⃣ How do you pull latest changes from remote repository?

--> git pull origin main
fetches + merges latest changes from remote branch to local branch.

git fetch --> download remote commits to local repository.
git pull  --> fetches + merges remote  commits to local repository.

-----------------------------------------------------------------------------
🔟 How do you create and switch to a new branch?

Command:

git checkout -b feature/add-jenkinsfile

Explanation:
Creates and switches to a new branch in one command.

------------------------------------------------------------------------------

11️⃣ How do you list all branches?

Command: -- git branch

Explanation:
Displays all local branches.
Use git branch -a to show both local and remote branches.
----------------------------------------------------------------------

12️⃣ How do you switch to another branch?

Command:--git checkout main

or in newer versions: --git switch main

--------------------------------------------------------------------

13️⃣ How do you merge one branch into another?

Command:
git checkout main
git merge feature/add-jenkinsfile

Explanation:
Merges changes from feature/add-jenkinsfile into main.


14️⃣ How do you resolve merge conflicts?

Answer:
When merging, if the same line of code is modified in both branches, Git shows conflict markers:

<<<<<<< HEAD
code from main
=======
code from feature
>>>>>>> feature/add-jenkinsfile


You must manually edit, remove conflict markers, then:

git add .
git commit




------------------------------------------------------------------------------------------------------------------------------------------
jenkins CI-CD interview questions:-



JENKINS server is on ec2 8 gb this 8gb storage is completely utilized how will you allocate extra resource.

first i will check disk status using df -h command.
Jenkins agent node is actually running pipeline and jobs. jenkins agent having workspaces at location(var/lib/jenkins/workspace  and in which old logs, docker images 
so we need to clear this first. if this cleaup is not ssufficient then i will inrease EBS volume size from aws console. aws supports live volume resizing without 
downtime.
i will extend the filesystem.
sudo growpart /dev/xvda 1
sudo resize2fs /dev/xvda1

------------------------------------------------------------------------------------------------------------------------------------------------------
Q) after scanning the docker images what trivy provide to us?
  After scanning docker image through trivy , trivy provide detailed vulnerability report that shows all the security issue in image OS package.
   The output provide in json format and contains below.
      1) vulnerability ID (CVE ID)
      2) package name and version
      3) severity level(critical, high, medium, low)
      4) installed vs fixed version.
      5) short description of the issue.
      6) references or links for remediation.
--------------------------------------------------------------------------------------------------------------------------------------------------------
Q)  What sonarqube provide to us?

   sonarqube is code quality and security analysis tool which will help us to identify bugs,code smell, vulnerabilities, code duplication in our source code before deployment.
    it basically enforces code quality gates in cicd pipeline- means code will pass to next stage only when it meets defined code quality standard.
    bugs - logic or runtime errors - nul    l pointer deference
    code smells - bad coding practices or mantainability issue large functions, unused variables.
    vulnerabilities - security flaws -   SQL injection, hardcoded password
   Duplication -  Repeated code blocks  - copy-paste same logic across files. 
   coverage - how much code is covered by unit test  - 80% coverage threshold
  
SonarQube helps us maintain high code quality and security by analyzing our code for bugs, vulnerabilities, and code smells.
It also enforces automated quality gates in Jenkins so that bad code never gets deployed.


sonarqube scans the code for issues related to maintainability, readability and design quality -these are called code smells.
maintainability - How easy it is modify, fix and enhance code in future. -- if a function 300 lines long and does 5 different thing then changing one part might break                    something else. --Thats poor maintainability.
Readability - How easy it is for another developer to understand the code without much explanation.- Readable code saves time during debugging and collaboration.
Design Quality - How well the overall structure of code follows software engineering best practices- like modularity, reusability, and seperation of concerns.
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

Q) I want my pipeline continue even if one stage fails-how will i do?
    we can use catchError step
    catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE'
    marks the stage is failed,but does not stop the pipeline. --

----------------------------------------------------------------------------------------------------------

Q) how do you handle conditional execution in pipeline?
 
stage('Deploy') {
  when {
    branch 'main'
  }
  steps {
   echo 'Deploy to Prod'
  }
 }

------------------------------------------------------------------------------------------------
Q) what do you understand by POST block in jenkins?
  post {
    always {
      echo 'Cleanup'
    }
    success {
      echo 'Build Succeedeed'
    } 
     failure {
      echo 'Build Failure'

post block is used to define actions that should run after a stage or pipeline complete.



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------



