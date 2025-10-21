virtulization-virtulization is technology that lets you create virtual versions of physical servers (like server , storage, network) on a single piece of hardware. it abstracts underlying hardware, allowing multiple isolated environemnts -called virtual machines (vm) to run simeltaneoulsy without interfering.

Host vs Guest - the host is physical device (laptop) guests are the VMs running on it(linux server VM)


Hypervisor--Hypervisor is software that creates, runs and manage VMs.
A hypervisor acts as an abstraction layer between the physical hardware and the virtual machines. Its primary role is to virtulize hardware resources such as CPU, memory, storage, and network, and allocate them to guest operating systems.

Instead of each VM directly interacting with the physical hardware, the hypervisor provides a virtualized version of these resources. This allows multiple VMs with different operating systems to run on the same host machine securely and independently.

For example, if I have a host with 32 GB RAM and 16 vCPUs, the hypervisor can slice these resources and allocate, say, 8 GB RAM and 4 vCPUs to one VM, 4 GB RAM and 2 vCPUs to another, and so on. Each VM feels as though it has its own dedicated hardware, while in reality, it's sharing resources from the same host.

This abstraction is the foundation of virtualization and is critical for server consolidation, efficient resource utilization, and scalability in cloud environments. In my projects, I’ve worked with both Type 1 (bare-metal) hypervisors like VMware ESXi and KVM, as well as Type 2 (hosted) hypervisors like VirtualBox, depending on the use case


Benefits (Why Interviewers Love This)
Efficiency: One server runs 10+ VMs, cutting hardware costs by 70-80%.
Isolation: A crash in one VM doesn't affect others—crucial for SRE reliability.
Scalability: Spin up VMs on-demand (e.g., auto-scaling in AWS).
Testing/DevOps: Reproducible environments; snapshot for "what if" scenarios.
Security: Sandbox malware analysis or multi-tenant clouds.

Drawbacks with hypervisor- 
hypervisor provides resources from host os(physical machine) to virtual machine. each virtual machine running with dedicated CPU, RAM, Storage considering full guest OS. it leads to slower performance 
Each VM required its own OS kernel libraries and dependencies, this increase disk and memoey consumption. 
Starting VM takes longer time because it needs to boot an entire operating system. 

