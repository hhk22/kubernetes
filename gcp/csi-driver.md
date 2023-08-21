
## gcp-compute-persistent-disk-csi-driver 설치.

### 권한설정

```
gcloud init --no-browser --console-only

mkdir ~/go
export GOPATH=$HOME/go

mkdir -p /go/bin
mkdir /go/pkg
mkdir /go/src

git clone https://github.com/kubernetes-sigs/gcp-compute-persistent-disk-csi-driver.git $GOPATH/src/sigs.k8s.io/gcp-compute-persistent-disk-csi-driver

export PROJECT=praxis-works-388411
export GCE_PD_SA_NAME=my-gce-pd-csi-sa
export GCE_PD_SA_DIR=~/gce_pd_sa_dir
export ENABLE_KMS=false
export ENABLE_KMS_ADMIN=false

mkdir ~/gce_pd_sa_dir

sh ./deploy/setup-project.sh

```

## CSI_DRIVER 설치 && 실행하기 

```
export GCE_PD_DRIVER_VERSION=stable-master
sh ./deploy/kubernetes/deploy-driver.sh

kubectl apply -f examples/kubernetes/demo-zonal-sc.yaml
kubectl apply -f examples/kubernetes/demo-pod.yaml


```