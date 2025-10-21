persistent storage required for mysql database pods.
storage class ask kubernetes to provision storage from backend(aws)
we have mentioed pvc in deployment manifiest to provide required storage eg(20Gi Volume) and pvc requested to stoarage class for storage. 
Then storage class and CSI driver talk to AWS and provision EBS volume. then pv binds to PVC.
In the depployment pod spec used volume --> persistentvolumeclaim
the volume is mounted inside the mysql container at var/lib/mysql. so mysql store all its data in the PV.

storage class - provision the required storage type.
PVC - requested storage to storageclass.
PV- kubernetes provision with using csi driver and bind it to PVC.


