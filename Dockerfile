FROM golang AS builder

WORKDIR /root
RUN git clone https://github.com/nezhahq/agent

WORKDIR /root/agent/cmd/agent
RUN env CGO_ENABLED=0 \
    go build -v -trimpath -ldflags \
    "-s -w -X github.com/nezhahq/agent/pkg/monitor.Version=1.13.0"

FROM alpine

# Copy the binary from the builder stage
RUN apk add --no-cache util-linux
COPY --from=builder /root/agent/cmd/agent/agent /usr/local/bin/nezha-agent

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
