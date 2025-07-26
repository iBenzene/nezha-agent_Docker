# Nezha Agent

基于 Alpine Linux 构建的 Nezha Agent 镜像，兼容 Nezha v1，支持配置宿主机的 OS 和版本号。

## Quick Start

``` bash
sudo docker run -d -v=./nezha-agent:/opt/nezha-agent \
    --name=nezha-agent \
    --restart=unless-stopped \
    --net=host \
    --cap-add=NET_RAW \
    -e OS=your_os_name \
    -e OS_VERSION=your_os_version \
    -e SECRET=your_client_secret \
    -e SERVER=example.com:443 \
    -e TLS=true \
    ghcr.io/ibenzene/nezha-agent
```

## Docker Compose

``` yaml
services:
  agent:
    image: ghcr.io/ibenzene/nezha-agent
    container_name: nezha-agent
    restart: unless-stopped
    network_mode: host
    volumes:
      - ./nezha-agent:/opt/nezha-agent
    environment:
      - OS=your_os_name
      - OS_VERSION=your_os_version
      - SECRET=your_client_secret
      - SERVER=example.com:443
      - TLS=true
    cap_add:
      - NET_RAW
```
