$ kubectl create -f hpa.yaml
deployment "hpa-example" created
service "hpa-example" created
horizontalpodautoscaler "hpa-example" created

$ kubectl get hpa
NAME          REFERENCE                TARGETS    MINPODS   MAXPODS   REPLICAS   AGE
hpa-example   Deployment/hpa-example   0% / 50%   1         6         1          7m

$ kubectl run -i -t --rm busybox --image=busybox
$ while true; do wget -q -O- http://hpa-example; done

$ kubectl get hpa --watch
NAME          REFERENCE                TARGETS     MINPODS   MAXPODS   REPLICAS   AGE
hpa-example   Deployment/hpa-example     0% / 50%   1         6         1         12m
hpa-example   Deployment/hpa-example   522% / 50%   1         6         1         12m
hpa-example   Deployment/hpa-example   522% / 50%   1         6         1         12m
hpa-example   Deployment/hpa-example   941% / 50%   1         6         1         13m
hpa-example   Deployment/hpa-example   941% / 50%   1         6         4         13m
hpa-example   Deployment/hpa-example   362% / 50%   1         6         4         14m
hpa-example   Deployment/hpa-example   362% / 50%   1         6         4         14m
hpa-example   Deployment/hpa-example    12% / 50%   1         6         4         15m
hpa-example   Deployment/hpa-example    12% / 50%   1         6         4         15m
hpa-example   Deployment/hpa-example     0% / 50%   1         6         4         16m
