$ kubectl create -f deployment.yaml --record=true
deployment "echoserver" created

$ kubectl set image deployment/echoserver echoserver=gcr.io/google-containers/echoserver:1.2
deployment "echoserver" image updated

$ kubectl rollout status deployment/echoserver
Waiting for rollout to finish: 1 out of 3 new replicas have been updated...
Waiting for rollout to finish: 1 out of 3 new replicas have been updated...
Waiting for rollout to finish: 2 out of 3 new replicas have been updated...
Waiting for rollout to finish: 2 out of 3 new replicas have been updated...
Waiting for rollout to finish: 2 out of 3 new replicas have been updated...
Waiting for rollout to finish: 1 old replicas are pending termination...
Waiting for rollout to finish: 1 old replicas are pending termination...
deployment "echoserver" successfully rolled out


$ kubectl set image deployment/echoserver echoserver=gcr.io/google-containers/echoserver:1.3
deployment "echoserver" image updated

$ kubectl rollout history deployment/echoserver
deployments "echoserver"
REVISION        CHANGE-CAUSE
1               kubectl create --filename=deployment.yaml --record=true
2               kubectl set image deployment/echoserver echoserver=gcr.io/google-containers/echoserver:1.2
3               kubectl set image deployment/echoserver echoserver=gcr.io/google-containers/echoserver:1.3

$ kubectl rollout history deployment/echoserver --revision=2
deployments "echoserver" with revision #2
Pod Template:
  Labels:       app=echoserver
        pod-template-hash=1885346732
  Annotations:  kubernetes.io/change-cause=kubectl set image deployment/echoserver echoserver=gcr.io/google-containers/echoserver:1.2
  Containers:
   echoserver:
    Image:      gcr.io/google-containers/echoserver:1.2
    Port:       8080/TCP
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>


$ kubectl rollout undo deployment/echoserver
deployment "echoserver" rolled back

$ kubectl rollout history deployment/echoserver
deployments "echoserver"
REVISION        CHANGE-CAUSE
1               kubectl create --filename=deployment.yaml --record=true
3               kubectl set image deployment/echoserver echoserver=gcr.io/google-containers/echoserver:1.3
4               kubectl set image deployment/echoserver echoserver=gcr.io/google-containers/echoserver:1.2


$ kubectl rollout undo deployment/echoserver --to-revision=1
deployment "echoserver" rolled back

$ kubectl rollout history deployment/echoserver
deployments "echoserver"
REVISION        CHANGE-CAUSE
3               kubectl set image deployment/echoserver echoserver=gcr.io/google-containers/echoserver:1.3
4               kubectl set image deployment/echoserver echoserver=gcr.io/google-containers/echoserver:1.2
5               kubectl create --filename=deployment.yaml --record=true


$ kubectl scale deployment/echoserver --replicas 6
deployment "echoserver" scaled

$ kubectl get deployment/echoserver
NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
echoserver   6         6         6            6           11m

