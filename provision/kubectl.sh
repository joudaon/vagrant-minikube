#!/bin/bash

# Dowload page: https://github.com/kubernetes/kubectl/releases

kubectl_version="v1.17.4"

echo "--> Installing kubectl."

cd /tmp
curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/$kubectl_version/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version
echo "kubectl Version --> $(kubectl version)"

echo "--> kubectl successfully installed."