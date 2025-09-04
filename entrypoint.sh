#!/bin/sh

# Check if SECRET and SERVER are set, if not, exit with an error
if [ -z "${SECRET}" ] && [ -z "${SERVER}" ]; then
    echo "Error: SECRET and SERVER environment variables must be set."
    exit 1
fi

# Modified OS information
if [ -n "${OS}" ] || [ -n "${OS_VERSION}" ]; then
    rm -rf /etc/alpine-release && rm -rf /etc/debian_version
    if [ -n "${OS}" ]; then
        sed -i "s/^ID=.*/ID=${OS}/" /etc/os-release
    fi

    if [ -n "${OS_VERSION}" ]; then
        sed -i "s/^VERSION_ID=.*/VERSION_ID=${OS_VERSION}/" /etc/os-release
    fi
fi

# Create configuration file if it does not exist
CONFIG_FILE=/opt/nezha/agent/config.yml
if [ ! -f "${CONFIG_FILE}" ]; then
    UUID=$(uuidgen)

    cat << EOF > $CONFIG_FILE
client_secret: ${SECRET}
server: '${SERVER}'
tls: ${TLS:-false}
uuid: ${UUID}
gpu: ${GPU:-false}
EOF
fi

# Start the Nezha Agent
exec /usr/local/bin/nezha-agent -c=$CONFIG_FILE
