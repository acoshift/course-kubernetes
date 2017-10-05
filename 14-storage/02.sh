$ gcloud compute disks create --size=10GB --zone=asia-southeast1-b --project=acoshift-k8s disk-1
Created [https://www.googleapis.com/compute/v1/projects/acoshift-k8s/zones/asia-southeast1-b/disks/disk-1].
NAME    ZONE               SIZE_GB  TYPE         STATUS
disk-1  asia-southeast1-b  10       pd-standard  READY

$ kubectl create -f 02-pv.yaml
persistentvolume "disk-1" created

$ kubectl get pv
NAME      CAPACITY   ACCESSMODES   RECLAIMPOLICY   STATUS      CLAIM     STORAGECLASS   REASON    AGE
disk-1    10Gi       RWO           Retain          Available                                      12s

$ kubectl create -f 02-pvc.yaml
persistentvolumeclaim "mysql-pvc" created

$ kubectl get pv
NAME      CAPACITY   ACCESSMODES   RECLAIMPOLICY   STATUS    CLAIM               STORAGECLASS   REASON    AGE
disk-1    10Gi       RWO           Retain          Bound     default/mysql-pvc   standard                 1m

$ kubectl get pvc
NAME        STATUS    VOLUME    CAPACITY   ACCESSMODES   STORAGECLASS   AGE
mysql-pvc   Bound     disk-1    10Gi       RWO           standard       34s

$ kubectl create -f 02-mysql.yaml
deployment "mysql" created

$ kubectl get po
NAME                   READY     STATUS    RESTARTS   AGE
mysql-68058648-d3m8l   1/1       Running   0          48s

$ kubectl delete po/mysql-68058648-d3m8l
pod "mysql-68058648-d3m8l" deleted

$ kubectl get po
NAME                   READY     STATUS    RESTARTS   AGE
mysql-68058648-rsqk1   1/1       Running   0          4s


$ kubectl delete deploy/mysql pvc/mysql-pvc pv/disk-1
deployment "mysql" deleted
persistentvolumeclaim "mysql-pvc" deleted
persistentvolume "disk-1" deleted

$ gcloud compute disks delete --zone=asia-southeast1-b --project=acoshift-k8s disk-1
The following disks will be deleted:
 - [disk-1] in [asia-southeast1-b]

Do you want to continue (Y/n)?  Y

Deleted [https://www.googleapis.com/compute/v1/projects/acoshift-k8s/zones/asia-southeast1-b/disks/disk-1].
