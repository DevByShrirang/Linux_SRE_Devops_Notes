VPC Peering is used to establish private network connectivity between two VPCs — either within the same AWS account or across different AWS accounts and even different regions.

So the answer is: ✅ Both intra-network and cross-network VPC communication are supported.

Intra-network (same account):
Useful when teams want to isolate services in different VPCs (e.g., dev and prod), but still need them to communicate securely.

Cross-network (different accounts or regions):
Ideal in multi-account setups, such as when a shared services VPC (like logging, auth, or EKS) needs to be accessed by VPCs in other accounts.

🔒 Traffic flows privately over AWS's backbone without traversing the internet.

Limitations to highlight (interview point):
No transitive routing: if A ↔ B and B ↔ C, A cannot reach C.
Cannot use overlapping CIDRs.
No security group referencing across peered VPCs (use TGW or PrivateLink for that).

