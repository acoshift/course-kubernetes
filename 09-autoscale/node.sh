$ gcloud alpha container clusters update cluster-1 \
  --enable-autoscaling \
  --min-nodes=2 \
  --max-nodes=6 \
  --zone=asia-southeast1-b \
  --node-pool=default-pool \
  --project=acoshift-k8s
