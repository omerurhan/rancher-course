## Continuous Delivery with Rancher

## Configure Continuous Delivery

- Add Labels to the Clusters
- Create Cluster Groups
- Configure a Git Repo
```
# Create namespace
k create ns hello-rancher

Name hello-repo
Repository URL https://github.com/omerurhan/hello-rancher
Branch Name main
Paths Add Path → hello-rancher
Deploy To rke-group

change PETS -> cowmeleons
change COLOR -> green

```
- Verify the Application Delivery
- Modify the Application Configuration Manually
- Install CIS benchmart helm with fleet
