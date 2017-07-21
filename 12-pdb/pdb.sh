$ kubectl get no
NAME                                       STATUS    AGE       VERSION
gke-cluster-2-default-pool-75546f17-39fq   Ready     10m       v1.7.0
gke-cluster-2-default-pool-75546f17-9dc5   Ready     10m       v1.7.0
gke-cluster-2-default-pool-75546f17-xr57   Ready     10m       v1.7.0

$ kubectl get po
NAME                          READY     STATUS    RESTARTS   AGE
echoserver-1994896057-4lk6s   1/1       Running   0          50s
echoserver-1994896057-f0rft   1/1       Running   0          51s
echoserver-1994896057-p0lpr   1/1       Running   0          42s

$ kubectl drain gke-cluster-2-default-pool-75546f17-39fq --force --ignore-daemonsets
node "gke-cluster-2-default-pool-75546f17-39fq" already cordoned
pod "kube-dns-autoscaler-3880103346-4qj3t" evicted
pod "kube-dns-1413379277-h96k0" evicted
node "gke-cluster-2-default-pool-75546f17-39fq" drained

$ kubectl get no
NAME                                       STATUS                     AGE       VERSION
gke-cluster-2-default-pool-75546f17-39fq   Ready,SchedulingDisabled   16m       v1.7.0
gke-cluster-2-default-pool-75546f17-9dc5   Ready                      16m       v1.7.0
gke-cluster-2-default-pool-75546f17-xr57   Ready                      16m       v1.7.0

$ kubectl drain gke-cluster-2-default-pool-75546f17-9dc5 --force --ignore-daemonsets
node "gke-cluster-2-default-pool-75546f17-9dc5" already cordoned
pod "heapster-v1.4.0-2764992688-5xp57" evicted
pod "kubernetes-dashboard-1962351010-2xtq1" evicted
pod "echoserver-1994896057-f0rft" evicted
pod "l7-default-backend-2954409777-d4x3g" evicted
pod "event-exporter-v0.1.4-1771975458-s86dg" evicted
# hang
pod "echoserver-1994896057-p0lpr" evicted
node "gke-cluster-2-default-pool-75546f17-9dc5" drained

$ kubectl get no
NAME                                       STATUS                     AGE       VERSION
gke-cluster-2-default-pool-75546f17-39fq   Ready,SchedulingDisabled   18m       v1.7.0
gke-cluster-2-default-pool-75546f17-9dc5   Ready,SchedulingDisabled   18m       v1.7.0
gke-cluster-2-default-pool-75546f17-xr57   Ready                      18m       v1.7.0

$ kubectl get po
NAME                          READY     STATUS    RESTARTS   AGE
echoserver-1994896057-1tg93   0/1       Pending   0          1m
echoserver-1994896057-1w5s7   1/1       Running   0          1m
echoserver-1994896057-4lk6s   1/1       Running   0          7m

$ kubectl describe po/echoserver-1994896057-1tg93
...
Events:
  FirstSeen	LastSeen	Count	From			SubObjectPath	Type		Reason			Message
  ---------	--------	-----	----			-------------	--------	------			-------
  1m		1m		5	default-scheduler			Warning		FailedScheduling	No nodes are available that match all of the following predicates:: Insufficient cpu (1), PodToleratesNodeTaints (1).
...

$ kubectl uncordon gke-cluster-2-default-pool-75546f17-39fq
node "gke-cluster-2-default-pool-75546f17-39fq" uncordoned

$ kubectl get no
NAME                                       STATUS                     AGE       VERSION
gke-cluster-2-default-pool-75546f17-39fq   Ready                      22m       v1.7.0
gke-cluster-2-default-pool-75546f17-9dc5   Ready,SchedulingDisabled   22m       v1.7.0
gke-cluster-2-default-pool-75546f17-xr57   Ready                      22m       v1.7.0

$ kubectl get po
NAME                          READY     STATUS    RESTARTS   AGE
echoserver-1994896057-1tg93   1/1       Running   0          4m
echoserver-1994896057-1w5s7   1/1       Running   0          4m
echoserver-1994896057-4lk6s   1/1       Running   0          10m

$ kubectl uncordon gke-cluster-2-default-pool-75546f17-9dc5
node "gke-cluster-2-default-pool-75546f17-9dc5" uncordoned

$ kubectl get no
NAME                                       STATUS    AGE       VERSION
gke-cluster-2-default-pool-75546f17-39fq   Ready     25m       v1.7.0
gke-cluster-2-default-pool-75546f17-9dc5   Ready     25m       v1.7.0
gke-cluster-2-default-pool-75546f17-xr57   Ready     25m       v1.7.0
