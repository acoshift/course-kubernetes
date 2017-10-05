$ kubectl get storageclass
NAME                 TYPE
standard (default)   kubernetes.io/gce-pd

$ kubectl describe storageclass standard
Name:           standard
IsDefaultClass: Yes
Annotations:    storageclass.beta.kubernetes.io/is-default-class=true
Provisioner:    kubernetes.io/gce-pd
Parameters:     type=pd-standard
Events:         <none>

$ kubectl create -f 01-storageclass.yaml
storageclass "ssd" created

$ kubectl get storageclass
NAME                 TYPE
ssd                  kubernetes.io/gce-pd
standard (default)   kubernetes.io/gce-pd
