## User Management with Rancher

### Create local user

- Create local user and give related permission on UI

### Configure External OpenLDAP Authetication Provider

- Create openLDAP on upstream cluster

```
vagrant ssh upstream-01
sudo -i

# Install openLDAP
kubectl create ns openldap

helm repo add helm-openldap https://jp-gouin.github.io/helm-openldap/

# Create values.yaml
cat > values.openldap.yaml <<EOF
global:
  ldapDomain: "lab.io"
phpldapadmin:
  ingress:
    hosts:
    - openldap.lab.io
persistence:
  enabled: false
customTLS:
  enabled: false
  image:
    repository: shamelesscookie/openssl
    tag: latest
ltb-password:
  ingress:
    hosts:
    - ltb.lab.io
image:
  repository: bitnami/openldap
  tag: 2.6.4
EOF

# Install OpenLDAP
helm install openldap helm-openldap/openldap-stack-ha -f values.openldap.yaml
kubectl patch ingress openldap-phpldapadmin -p '{"spec":{"ingressClassName":"nginx"}}'
k scale sts openldap --replicas 1

Connect UI and configure ldap
DN = cn=user02,ou=users,dc=lab,dc=io
Search Base = ou=users,dc=lab,dc=io
```
- Manage Roles & Permissions





