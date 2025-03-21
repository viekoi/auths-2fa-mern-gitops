#!/bin/bash
set -e

EMAIL=$1
KEY_NAME=$2
GIT_REPO=$3
NAMESPACE="argocd"
SECRET_NAME="ecr-argo-image-updater"

if [ -z "$EMAIL" ]; then
  echo "Error: EMAIL argument is required. Usage: $0 <email> <key-name> <git-repo>"
  exit 1
fi

if [ -z "$KEY_NAME" ]; then
  echo "Error: KEY_NAME argument is required. Usage: $0 <email> <key-name> <git-repo>"
  exit 1
fi

if [ -z "$GIT_REPO" ]; then
  echo "Error: GIT_REPO argument is required. Usage: $0 <email> <key-name> <git-repo>"
  exit 1
fi

SSH_DIR="$HOME/.ssh"
KEY_FILE="$SSH_DIR/$KEY_NAME"

# Check if key exists, use it if it does
if [ -f "$KEY_FILE" ] && [ -f "$KEY_FILE.pub" ]; then
  echo "Using existing SSH key: $KEY_FILE"
else
  echo "Generating new SSH key: $KEY_FILE"
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY_FILE" -N "" >/dev/null 2>&1
fi

# Display the public key
cat "$KEY_FILE.pub"

# Get the private key content
PRIVATE_KEY=$(cat "$KEY_FILE")

# Create or update the Kubernetes secret
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: $SECRET_NAME
  namespace: $NAMESPACE
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  url: $GIT_REPO
  sshPrivateKey: |
$(echo "$PRIVATE_KEY" | sed 's/^/    /')
  insecure: "false"
  enableLfs: "true"
EOF