## Rancher Security Tools

### Configure CIS Scanning

- Install CIS Benchmark Helm Chart
- Run a Security Scan with CIS Benchmark

```
# Label workaround for non rke clusters
k label node MYNODE kubernetes.azure.com/cluster=""

```

### Configure OPA Gatekeeper

- Install OPA Gatekeeper Helm Chart
- Configure OPA Gatekeeper Constraints
- Verify the OPA Gatekeeper Policy Constraints
- Check the OPA Gatekeeper Policy Violations
- Delete the Policy Constraints



