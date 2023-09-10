## Rancher Logging and Monitoring

## Deploy monitoring stack on downstream cluster

- Deploy Monitoring Helm Chart
- Inspect the Monitoring Features

## Deploy Logging on a Downstream Cluster

- Deploy the Logging Helm Chart
- Create clusterflow, clusteroutput
- Deploy single node elasticsearch and kibana

``` 
# Install elasticsearch
cat > values.elastic.yaml <<EOF
# Version: 7.17.3
replicas: 1
extraEnvs:
- name: discovery.type
  value: single-node
- name: cluster.initial_master_nodes
  value: ""
resources:
  requests:
    cpu: "100m"
    memory: "500Mi"
  limits:
    cpu: "400m"
    memory: "1Gi"
EOF

helm repo add elastic https://helm.elastic.co
helm repo update
helm upgrade --install elasticsearch elastic/elasticsearch \
  --version 7.17.3 \
  --namespace logging \
  -f values.elastic.yaml \
  --create-namespace

# Install Kibana
cat > values.kibana.yaml <<EOF
elasticsearchHosts: "http://elasticsearch-master:9200"

ingress:
  enabled: true
  className: "nginx"
  pathtype: ImplementationSpecific
  hosts:
    - host: kibana.lab.io
      paths:
        - path: /
resources:
  requests:
    cpu: "200m"
    memory: "100Mi"
  limits:
    memory: "1Gi"
EOF

helm repo add elastic https://helm.elastic.co
helm repo update
helm upgrade --install kibana elastic/kibana \
  --version 7.17.3 \
  --namespace logging \
  -f values.kibana.yaml \
  --create-namespace
```
- Inspect logs on kibana


