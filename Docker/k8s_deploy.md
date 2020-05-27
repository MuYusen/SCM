# Step

## install docker

```bash

# step 1: 安装必要的一些系统工具

sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common

# step 2: 安装GPG证书

curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

# Step 3: 写入软件源信息

sudo add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# Step 4: 更新并安装 Docker-CE

sudo apt-get -y update
sudo apt-get -y install docker-ce
 
安装指定版本的Docker-CE:

Step 1: 查找Docker-CE的版本:

 apt-cache madison docker-ce
   docker-ce | 17.03.1~ce-0~ubuntu-xenial | http://mirrors.aliyun.com/docker-ce/linux/ubuntu xenial/stable amd64 Packages
   docker-ce | 17.03.0~ce-0~ubuntu-xenial | http://mirrors.aliyun.com/docker-ce/linux/ubuntu xenial/stable amd64 Packages

Step 2: 安装指定版本的Docker-CE: (VERSION 例如上面的 17.03.1~ce-0~ubuntu-xenial)

为docker group and添加用户user:

step 1: 使用具有sudo权限得用户登录Ubuntu.

step 2: 创建docker group.

	$ sudo groupadd docker

step 3: 添加user到docker group.

	$ sudo usermod -aG docker $USER

```
## stop swap

```
vi /etc/fstab

#UUID=fe5dd8a4-0222-4e21-b926-1f97b4685ffd none            swap    sw              0       0 # 注释掉最后一行与swap 相关的

```

## install k8s with kubeadm

### 官方

```bash

apt-get update && apt-get install -y apt-transport-https curl

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

```

### 阿里

```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https curl

sudo curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

sudo tee /etc/apt/sources.list.d/kubernetes.list <<-'EOF'
deb https://mirrors.aliyun.com/kubernetes/apt kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable kubelet && sudo systemctl start kubelet

```
## load_images

## 用kubeadm创建cluster

### 查看需要的image list

```bash
$ kubeadm config images list
I0228 16:49:52.481842   15756 version.go:94] could not fetch a Kubernetes version from the internet: unable to get URL "https://dl.k8s.io/release/stable-1.txt": Get https://storage.googleapis.com/kubernetes-release/release/stable-1.txt: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
I0228 16:49:52.481941   15756 version.go:95] falling back to the local client version: v1.13.3
k8s.gcr.io/kube-apiserver:v1.13.3
k8s.gcr.io/kube-controller-manager:v1.13.3
k8s.gcr.io/kube-scheduler:v1.13.3
k8s.gcr.io/kube-proxy:v1.13.3
k8s.gcr.io/pause:3.1
k8s.gcr.io/etcd:3.2.24
k8s.gcr.io/coredns:1.2.6

```

### 初始化master

在Master上执行如下命令：

```
sudo kubeadm init --apiserver-advertise-address 192.168.57.150 --pod-network-cidr=10.244.0.0/16

```

+ --apiserver-advertise-address 指明用Master的那个interface与cluster的其他节点通信。--pod-network-cidr 指定Pod网络的范围。
+ 初始化过程：
	- kubeadm执行初始化前的检查
	- 生成token和证书
	- 生成Kubeconfig文件，kubelet需要用这个文件与Master通信
	- 安装Master 组件，（下载镜像）
	- 安装附加组件kube-proxy和kube-dns
	- Kubernetes Master初始化成功。
	- 提示如何配置kubectl
	- 提示如何安装Pod网络 （kubectl apply -f [podnetwork].yaml）—— https://kubernetes.io/docs/concepts/cluster-administration/addons/
	- 提示如何注册其他节点到Cluster

### 配置kubectl

```
su - ${USER}
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "source < (kubectl completion bash)" >> ~/.bashrc

```

### 安装Pod网络

```
You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/
```

### 添加节点

```bash
You can now join any number of machines by running the following on each node
as root:

kubeadm join ...
```
