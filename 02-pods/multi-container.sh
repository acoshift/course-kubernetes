$ kubectl create -f multi-container.yaml
pod "web" created

$ kubectl port-forward web 8080:80
Forwarding from 127.0.0.1:8080 -> 80
Forwarding from [::1]:8080 -> 80

$ curl localhost:8080

$ kubectl exec web -itc ubuntu -- bash

root@web:/# apt-get update

root@web:/# apt-get install curl

root@web:/# curl localhost
s4zX9vA0juonZhYlCjfRiXUpIV54EsAfz+UwAgnrWhA=

root@web:/# curl localhost
n7dhG+ZDK//+vQm/M6upoA55JqK5lQ96tYsiDdGj+7M=

root@web:/# curl localhost -I
HTTP/1.1 200 OK
Server: nginx/1.11.1
Date: Fri, 21 Jul 2017 12:26:55 GMT
Content-Type: text/html
Content-Length: 45
Last-Modified: Fri, 21 Jul 2017 12:26:54 GMT
Connection: keep-alive
ETag: "5971f30e-2d"
Accept-Ranges: bytes

$ kubectl delete -f multi-container.yaml
pod "web" deleted
