# ========= 构建参数 =========
ARG VERSION=1.13.1

# ========= Alpine 镜像 =========
FROM alpine

WORKDIR /usr/local/bin

# Download the binary file of Nezha Agent
RUN apk add --no-cache util-linux wget unzip && \
    arch=$(uname -m | sed "s#x86_64#amd64#; s#aarch64#arm64#; s#i386#386#") && \
    wget -O nezha-agent.zip -t 4 -T 5 "https://github.com/nezhahq/agent/releases/download/v${VERSION}/nezha-agent_linux_${arch}.zip" && \
    unzip nezha-agent.zip && rm -f nezha-agent.zip && \
    chmod +x nezha-agent

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# ========= Debian 镜像 =========
FROM debian:12-slim

WORKDIR /usr/local/bin

# Download the binary file of Nezha Agent
RUN apt-get update && apt-get install -y --no-install-recommends uuid-runtime wget unzip && \
    rm -rf /var/lib/apt/lists/* && \
    arch=$(uname -m | sed "s#x86_64#amd64#; s#aarch64#arm64#; s#i386#386#") && \
    wget -O nezha-agent.zip -t 4 -T 5 "https://github.com/nezhahq/agent/releases/download/v${VERSION}/nezha-agent_linux_${arch}.zip" && \
    unzip nezha-agent.zip && rm -f nezha-agent.zip && \
    chmod +x nezha-agent

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
