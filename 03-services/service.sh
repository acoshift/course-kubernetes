$ kubectl create -f clusterIp.yaml
pod "echoserver" created
service "echoserver" created

$ kubectl get services
NAME         CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
echoserver   10.3.248.15  <none>        80/TCP    11s

$ kubectl run -i -t --rm busybox --image=busybox
$ wget -O - http://echoserver

$ kubectl delete -f clusterIp.yaml
