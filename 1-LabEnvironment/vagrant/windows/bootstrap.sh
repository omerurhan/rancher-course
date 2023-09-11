#! /bin/bash

# Become root
sudo -i

# Install Helm 
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update
apt-get install -y helm

### RKE2 INSTALLATION
## Install ansible
sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt update
sudo apt install -y ansible

# Install rke2 with ansible
git clone https://github.com/kloia/rke2-ansible.git
cd rke2-ansible
cat > inventory << EOF
[servers]
localhost rke2_type="server"

[all:vars]
ansible_user={{ ssh_user }} 
EOF
sed -i 's/ssh_user: ubuntu/ssh_user: vagrant/' /home/vagrant/rke2-ansible/vars/general-config.yml
sed -i 's/rke2_version: v1.24.12+rke2r1/rke2_version: v1.25.13+rke2r1/' /home/vagrant/rke2-ansible/vars/general-config.yml
grep -q 'connection' /home/vagrant/rke2-ansible/playbooks/rke2.yml || sed -i '/become: true/a \ \ connection: local' /home/vagrant/rke2-ansible/playbooks/rke2.yml
./provision.sh

### Install kubernets cluster with kubespray 
#git clone https://github.com/kubernetes-sigs/kubespray.git -b v2.22.0
#apt-get -y install python3-pip
#cd kubespray/
#pip3 install -r requirements.txt
#cp -rfp inventory/sample inventory/mycluster
#declare -a IPS=(`hostname -I`)
#
#CONFIG_FILE=inventory/mycluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}
#sed -i 's/container_manager: docker/container_manager: containerd/' inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
#sed -i 's/kube_network_plugin: calico/kube_network_plugin: cilium/' inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml
#
#sed -i 's/metrics_server_enabled: false/metrics_server_enabled: true/' inventory/mycluster/group_vars/k8s_cluster/addons.yml
#sed -i 's/# cilium_enable_portmap: false/cilium_enable_portmap: true/' inventory/mycluster/group_vars/k8s_cluster/k8s-net-cilium.yml
#
#ansible-playbook -i inventory/mycluster/hosts.yaml  --connection=local --become --become-user=root cluster.yml
## setup aliases for root
echo "alias kcd='kubectl config set-context $(kubectl config current-context) --namespace '" >> /root/.bash_aliases
echo "alias k='kubectl'" >> /root/.bash_aliases

# Install nginx ingress controller
# Version: 4.2.1
#cat > values.ingress.yaml << EOF
#controller:
#  kind: DaemonSet
#  healthCheckPath: "/healthz"
#  metrics:
#    port: 10254
#    enabled: true
#  hostNetwork: true  
#  hostPort:
#    enabled: true
#    ports:
#      http: 80
#      https: 443  
#EOF
#helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
#helm install ingress-nginx ingress-nginx/ingress-nginx --version 4.2.1 -f values.ingress.yaml -n ingress-nginx --create-namespace
#





