## Rancher Shell Access

### Access a Container from SUSE Rancher

- Access Shell Inside a Container

### kubectl Access from SUSE Rancher GUI

- Run kubectl Inside SUSE Rancher GUI

### kubectl Access from Bash Shell

- Access the Managed RKE Cluster From the Command Line
- Enable Authorized Endpoint on Cluster rke2
- Verify Shell Access By-Passing the Authentication Proxy

### Using the rancher CLI

- Using the rancher CLI
- Create an API Key for rancher CLI Access
- Access RKE2 Cluster From the Command Line

```
# Access cluster
rancher login https://rancher.lab.io --token <BEARER_TOKEN> --skip-verify
rancher --help
rancher clusters
rancher nodes

rancher kubectl get nodes
rancher context current
rancher context switch
rancher kubectl get nodes

rancher settings
```
- Configure Authorized Cluster Endpoint


