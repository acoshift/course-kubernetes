$ gcloud compute disks create --size=20GB --zone=asia-southeast1-b --project=acoshift-k8s mysql-disk
Created [https://www.googleapis.com/compute/v1/projects/acoshift-k8s/zones/asia-southeast1-b/disks/mysql-disk].
NAME        ZONE               SIZE_GB  TYPE         STATUS
mysql-disk  asia-southeast1-b  20       pd-standard  READY

$ kubectl create -f pd.yaml
deployment "mysql" created

$ kubectl get po
NAME                     READY     STATUS    RESTARTS   AGE
mysql-1398320157-mgf6c   1/1       Running   0          3m

$ kubectl port-forward mysql-1398320157-mgf6c 3306:3306

$ mysql -u root -p -h 127.0.0.1

mysql> create database db1;
Query OK, 1 row affected (0.05 sec)

mysql> use db1;
Database changed

mysql> create table users (
    -> id int auto_increment,
    -> name varchar(255) not null,
    -> created_at timestamp not null default now(),
    -> primary key (id)
    -> );
Query OK, 0 rows affected (0.08 sec)

mysql> insert into users (name) values ('acoshift'), ('user1'), ('user2');
Query OK, 3 rows affected (0.08 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> select * from users;
+----+----------+---------------------+
| id | name     | created_at          |
+----+----------+---------------------+
|  1 | acoshift | 2017-07-15 14:46:04 |
|  2 | user1    | 2017-07-15 14:46:04 |
|  3 | user2    | 2017-07-15 14:46:04 |
+----+----------+---------------------+
3 rows in set (0.03 sec)

mysql> exit
Bye


$ kubectl get po
NAME                     READY     STATUS    RESTARTS   AGE
mysql-1398320157-mgf6c   1/1       Running   0          19m

$ kubectl delete po/mysql-1398320157-mgf6c
pod "mysql-1398320157-mgf6c" deleted

$ kubectl get po
NAME                     READY     STATUS              RESTARTS   AGE
mysql-1398320157-d0scs   0/1       ContainerCreating   0          30s


$ kubectl get po
NAME                     READY     STATUS    RESTARTS   AGE
mysql-1398320157-d0scs   1/1       Running   0          6m

$ kubectl port-forward mysql-1398320157-d0scs 3306:3306
Forwarding from 127.0.0.1:3306 -> 3306
Forwarding from [::1]:3306 -> 3306

$ mysql -u root -p -h 127.0.0.1

mysql> use db1;
Database changed

mysql> select * from users;
+----+----------+---------------------+
| id | name     | created_at          |
+----+----------+---------------------+
|  1 | acoshift | 2017-07-15 14:46:04 |
|  2 | user1    | 2017-07-15 14:46:04 |
|  3 | user2    | 2017-07-15 14:46:04 |
+----+----------+---------------------+
3 rows in set (0.04 sec)

mysql> exit
Bye


$ kubectl delete -f pd.yaml
deployment "mysql" deleted

$ gcloud compute disks delete --zone=asia-southeast1-b --project=acoshift-k8s mysql-disk
The following disks will be deleted:
 - [mysql-disk] in [asia-southeast1-b]

Do you want to continue (Y/n)?  Y

Deleted [https://www.googleapis.com/compute/v1/projects/acoshift-k8s/zones/asia-southeast1-b/disks/mysql-disk].
