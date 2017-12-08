$ kubectl create -f https://raw.githubusercontent.com/cockroachdb/cockroach/master/cloud/kubernetes/cockroachdb-statefulset.yaml
service "cockroachdb-public" created
service "cockroachdb" created
poddisruptionbudget "cockroachdb-budget" created
statefulset "cockroachdb" created

$ kubectl create -f https://raw.githubusercontent.com/cockroachdb/cockroach/master/cloud/kubernetes/cluster-init.yaml

$ kubectl get po
NAME            READY     STATUS    RESTARTS   AGE
cockroachdb-0   1/1       Running   0          10m
cockroachdb-1   1/1       Running   0          9m
cockroachdb-2   1/1       Running   0          8m

$ kubectl port-forward cockroachdb-0 8080

$ kubectl run -it --rm cockroach-client --image=cockroachdb/cockroach --restart=Never --command -- ./cockroach sql --host cockroachdb-public --insecure

root@cockroachdb-public:26257/> create database db1;
CREATE DATABASE

root@cockroachdb-public:26257/> set database = db1;
SET

root@cockroachdb-public:26257/db1> create table users (
                                -> id serial,
                                -> name string not null default '',
                                -> created_at timestamp not null default now(),
                                -> primary key (id)
                                -> );
CREATE TABLE

root@cockroachdb-public:26257/db1> insert into users (name) values ('acoshift'), ('user1'), ('user2');
INSERT 3

root@cockroachdb-public:26257/db1> select * from users;
+--------------------+----------+----------------------------------+
|         id         |   name   |            created_at            |
+--------------------+----------+----------------------------------+
| 262376372306051076 | acoshift | 2017-07-15 17:55:14.366042+00:00 |
| 262376372306247684 | user1    | 2017-07-15 17:55:14.366042+00:00 |
| 262376372306345988 | user2    | 2017-07-15 17:55:14.366042+00:00 |
+--------------------+----------+----------------------------------+
(3 rows)
