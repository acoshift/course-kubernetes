$ echo -n "mysqlpassword" | base64
bXlzcWxwYXNzd29yZA==

$ kubectl create -f secret.yaml


$ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=echoserver.acoshift.com"
Generating a 2048 bit RSA private key
.....................................+++
...+++
writing new private key to 'tls.key'
-----

$ kubectl create secret tls echoserver-acoshift-com-tls --key=tls.key --cert=tls.crt
secret "echoserver-acoshift-com-tls" created
