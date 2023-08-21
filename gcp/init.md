
```

gcloud compute networks create hyeonghwan-k8s --subnet-mode custom
gcloud compute networks subnets create k8s-nodes --network hyeonghwan-k8s --range 10.240.0.0/24

gcloud compute firewall-rules create k8s-allow-internal \
--allow tcp,udp,icmp,ipip \
--network hyeonghwan-k8s \
--source-ranges 10.240.0.0/24

gcloud compute firewall-rules create k8s-allow-external \
--allow tcp:22,tcp:6443,icmp \
--network hyeonghwan-k8s \
--source-ranges 0.0.0.0/0

gcloud compute addresses create hyeonghwan-k8s

gcloud compute routers create k8s-router \
--network hyeonghwan-k8s \
--region asia-northeast3

gcloud compute routers nats create k8s-nats \
--router-region asia-northeast3 \
--router k8s-router \
--nat-all-subnet-ip-ranges \
--auto-allocate-nat-external-ips

gcloud compute firewall-rules create fw-allow-network-lb-health-checks \
--network=hyeonghwan-k8s \
--action=ALLOW \
--direction=INGRESS \
--source-ranges=35.191.0.0/16,209.85.152.0/22,209.85.204.0/22 \
--target-tags=allow-network-lb-health-checks \
--rules=tcp

gcloud compute instance-groups unmanaged create k8s-master \
--zone=asia-northeast3-a

gcloud compute instance-groups unmanaged add-instances k8s-master \
--zone=asia-northeast3-a \
--instances=controller-0

gcloud compute health-checks create https k8s-controller-hc --check-interval=5 \
--enable-logging \
--request-path=/healthz \
--port=6443 \
--region=asia-northeast3

gcloud compute backend-services create k8s-service \
--protocol TCP \
--health-checks k8s-controller-hc \
--health-checks-region asia-northeast3 \
--region asia-northeast3

gcloud compute backend-services add-backend k8s-service \
--instance-group k8s-master \
--instance-group-zone asia-northeast3-a \
--region asia-northeast3

gcloud compute forwarding-rules create k8s-forwarding-rule \
--load-balancing-scheme external \
--region asia-northeast3 \
--ports 6443 \
--address hyeonghwan-k8s \
--backend-service k8s-service

```


```

for i in 0 1 2; do
    gcloud compute instances create controller-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2004-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-2 \
    --private-network-ip 10.240.0.1${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet k8s-nodes \
    --tags k8s,controller
done

sudo apt update
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt -y install vim git curl wget kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo sed -i ' / swap /  s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

sudo tee /etc/modules-load.d/containered.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt install -y containerd.io
mkdir -p /etc/containerd
containerd config default>/etc/containerd/config.toml

sudo systemctl restart containerd
systemctl enable containerd
systemctl status containerd

sudo systemctl enable kubelet
sudo systemctl start kubelet

cat << EOF | sudo tee /etc/kubernetes/cloud-config
[Global]
project-id = praxis-works-388411
EOF

```


```
#controller-0

cat <<EOF > kubeadmcfg.yaml
...

sudo kubeadm init --upload-certs --config kubeadmcfg.yaml

```


```
 kubeadm join 34.64.72.142:6443 --token 4vh1z9.elheyth21azja2ev \
        --discovery-token-ca-cert-hash sha256:1c3407e804a20b2e729cb93ac78d09cb2358e1dce4df907609300405a1d0dbd1 \
        --control-plane --certificate-key 025cfb4f4369daab405e6b99ad19c66e5274ccb8f9d281b8bf8763ee755cfacf
```

## Worker Node.

```
for i in 0 1 2; do
    gcloud compute instances create worker-${i} \
    --async \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2004-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-2 \
    --metadata pod-cidr=10.200.${i}.0/24 \
    --private-network-ip 10.240.0.2${i} \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet k8s-nodes \
    --tags k8s,worker
done

gcloud compute ssh worker-0, 1, 2

sudo apt update
sudo apt install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y vim git curl wget kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo sed -i ' / swap /  s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

sudo tee /etc/modules-load.d/containered.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modeprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y containerd.io
sudo su -
mkdir -p /etc/containerd
containerd config default>/etc/containerd/config.toml

sudo systemctl restart containerd
systemctl enable containerd
systemctl status containerd

# SystemdCgroupu = false -> true
sudo systemctl restart containerd

sudo systemctl enable kubelet

kubeadm join 34.64.72.142:6443 --token 4vh1z9.elheyth21azja2ev \
        --discovery-token-ca-cert-hash sha256:1c3407e804a20b2e729cb93ac78d09cb2358e1dce4df907609300405a1d0dbd1

```

```

kubectl get csr | grep Pen | awk '{print "kubectl certificate approve "$1}' | bash
kubectl get csr  # check 

```


## CNI

```
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
curl https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml -O
kubectl create -f custom-resources.yaml

```