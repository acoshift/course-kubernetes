$ kubectl create -f cm.yaml
configmap "redis-config" created
service "redis" created
statefulset "redis" created

$ kubectl run -it --rm redis-client --image=redis --restart=Never --command -- bash
root@redis-client:/data# redis-cli -h redis

redis:6379> config get save
1) "save"
2) ""
