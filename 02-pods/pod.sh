$ kubectl create -f pod.yaml
pod "echoserver" created

$ kubectl get pods
NAME              READY     STATUS    RESTARTS   AGE
echoserver        1/1       Running   0          4m

$ kubectl port-forward echoserver 9000:8080
Forwarding from 127.0.0.1:9000 -> 8080
Forwarding from [::1]:9000 -> 8080

$ curl localhost:9000
Hostname: echoserver

Pod Information:
	-no pod information available-

Server values:
	server_version=nginx: 1.13.1 - lua: 10008

Request Information:
	client_address=127.0.0.1
	method=GET
	real path=/
	query=
	request_version=1.1
	request_uri=http://localhost:8080/

Request Headers:
	accept=*/*
	host=localhost:9000
	user-agent=curl/7.51.0

Request Body:
	-no body in request-

$ kubectl delete pod echoserver
pod "echoserver" deleted
