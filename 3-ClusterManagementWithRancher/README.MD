## Cluster Management with Rancher

### Import existing cluster

- Create cluster with kind and register to rancher
```
# connect to upstream-01 server
cd 3-ClusterManagementWithRancher
kind create cluster --config clusters.yaml --name dev
```

- Import existing cluster with UI

### Provision rke2 cluster

- Create RKE2 cluster on UI
- Connect downstream host and run registration command

Patch cluster-agent and fleet agent for DNS resolution
``````
      hostAliases:
      - ip: "host-ip-address" 
        hostnames: 
        - "rancher.lab.io"
``````
