# Cate k3s

```bash
# Prepare
apt update && apt upgrade -y && apt install -y git wget
git clone https://github.com/sirikon-experiments/cate-k3s.git
wget https://github.com/google/go-jsonnet/releases/download/v0.17.0/jsonnet-go_0.17.0_linux_amd64.deb
apt install ./jsonnet-go_0.17.0_linux_amd64.deb
```
