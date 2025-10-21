![alt text](image-1.png)

  PVC Issues:
  kubectl get pvc -n production
  NAME      STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
  my-pvc    Pending                                     gp2-test        3m


  kubectl describe pvc -n production
  Events:
    Type     Reason              Age                 From                         Message
    ----     ------              ----                ----                         -------
    Warning  ProvisioningFailed  10s (x3 over 1m)    persistentvolume-controller  storageclass.storage.k8s.io "gp2-test" not found

  error cause :-The PVC is referencing a StorageClass gp2-test which does not exist in the cluster.

  kubectl get sc
  NAME            PROVISIONER                   RECLAIMPOLICY               VOLUMEBINDINGMODE
  gp2             ebs.csi.aws.com                Delete                      WaitForFirstConsumer




  status for pvc showing bound when k8s successfully provisioned or matched a persistent volume to satisfy the claim and the pod can now mount and use that storage.

  for above issue to resolve we have edited sc and updated name from gp2-test to gp2

  then do kubectl apply -f sc_standard.yaml

  kubectl get sc
  NAME            PROVISIONER                   RECLAIMPOLICY               VOLUMEBINDINGMODE
  gp2             ebs.csi.aws.com                Delete                      WaitForFirstConsumer


  Then i will check status of pvc
  kubectl get pvc
  NAME      STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
  my-pvc    Bound    pvc-7c0f83a2-0d4e-4aa1-bda2-8efc4e5f3a13    5Gi        ReadWriteOnce  gp2-       3m






