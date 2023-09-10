## Introduction to Rancher 

### Install Rancher Server

Connect server and become root
```
# connect to upstream-01 server
vagrant ssh upstream-01
sudo -i 
```

Add Rancher Server Helm repo and create namespace
```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm search repo rancher-latest/rancher --versions
helm repo update

kubectl create namespace cattle-system

Choose your SSL Configuration
1 - Rancher-generated TLS certificate (need install cert-manager) *
2 - Let's Encrypt
3 - Bring your own certificate
```

Install cert-manager
```
# If you have installed the CRDs manually instead of with the `--set installCRDs=true` option added to your Helm install command, you should upgrade your CRD resources before upgrading the Helm chart:
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.crds.yaml

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.12.0
```
Install Rancher with specified values
```
cd ~
# Customize values yaml
cat > values.rancher.yaml << EOF
hostname: rancher.lab.io
ingress:
  ingressClassName: "nginx"
  tls:
    # options: rancher, letsEncrypt, secret
    source: rancher
    secretName: tls-rancher-ingress
global:
  cattle:
    psp:
      enabled: false
EOF

helm install rancher rancher-latest/rancher --version 2.7.6 -f values.rancher.yaml -n cattle-system --create-namespace

# To optimize resources
k scale deploy rancher --replicas 1

# get rancher ui password
kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}{{"\n"}}'

```

Connect https://rancher.lab.io



