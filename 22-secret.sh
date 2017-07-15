$ echo -n "testuser" | base64
dGVzdHVzZXI=
$ echo -n "testpassword" | base64
dGVzdHBhc3N3b3Jk

$ kubectl create -f 22-secret.yaml

$ kubectl get po
NAME                     READY     STATUS    RESTARTS   AGE
nginx-1183500012-cjcpq   1/1       Running   0          15s

$ kubectl port-forward nginx-1183500012-cjcpq 8080:80

$ curl localhost:8080/username
testuser

$ curl localhost:8080/password
testpassword


$ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=echoserver.acoshift.com"
Generating a 2048 bit RSA private key
.....................................+++
...+++
writing new private key to 'tls.key'
-----

$ kubectl create secret tls echoserver-acoshift-com-tls --key=tls.key --cert=tls.crt
secret "echoserver-acoshift-com-tls" created
