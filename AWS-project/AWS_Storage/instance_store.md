1. Instance Store (Ephemeral Storage)

Definition:

It’s local storage physically attached to the host running your EC2 instance.

Key Points:

Very low latency (because it’s local hardware).
Data is lost when instance is stopped or terminated (only survives reboot).
Cannot be encrypted, detached, or snapshotted.
Fixed size, tied to the instance type.
Best for temporary data, caching, or buffers.

✅ Example interview line:
“Instance store is ephemeral storage directly attached to the host, giving the best performance but no persistence beyond the instance lifecycle.”

💾 2. Elastic Block Store (EBS)

Definition:

Network-attached, persistent storage that lives independently of the EC2 instance.

Key Features:

Persists even if instance is stopped or terminated.
Can be detached and reattached to another EC2 instance.
Can grow in size without data loss (after resizing filesystem).
Can be encrypted (seamless, managed by AWS KMS).
Can be snapshotted anytime for backup or AMI creation.
Multiple volumes can be attached to one instance.
Within an Availability Zone, EBS is automatically replicated for reliability.

Reliability:

Availability: ~99.999% (“five nines”)

Annual Failure Rate: 0.1–0.2% (≈20× more reliable than normal hard disks)

✅ Example interview line:

“EBS provides persistent, network-attached block storage for EC2 with high durability, encryption, and snapshot support, making it ideal for databases or critical workloads.”