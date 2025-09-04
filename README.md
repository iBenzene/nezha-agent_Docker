# Nezha Agent

基于 Alpine Linux 构建的 Nezha Agent 镜像，兼容 Nezha v1，支持配置宿主机的 OS 和版本号。

## 快速开始

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
    ghcr.io/ibenzene/nezha-agent:1.13.1
```

或者

``` yaml
services:
  agent:
    image: ghcr.io/ibenzene/nezha-agent:1.13.1
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

## 特别说明

由于 NVIDIA 驱动是基于 GUN libc 构建的，而 Alpine Linux 使用的是 musl libc，因此如果要启用 GPU 监控功能的话，请使用基于 Debian 构建的镜像。

``` yaml
services:
  agent:
    image: ghcr.io/ibenzene/nezha-agent:1.13.1-debian
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
      - GPU=true
    cap_add:
      - NET_RAW
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: ["gpu"]
```
