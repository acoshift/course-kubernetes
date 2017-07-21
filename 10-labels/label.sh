$ kubectl get all -l app=echoserver
NAME                             READY     STATUS    RESTARTS   AGE
po/echoserver-3345770719-c5q61   1/1       Running   0          10s

NAME             CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
svc/echoserver   10.3.240.126   <none>        80/TCP    9s

NAME                DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/echoserver   1         1         1            1           10s

NAME                       DESIRED   CURRENT   READY     AGE
rs/echoserver-3345770719   1         1         1         10s
