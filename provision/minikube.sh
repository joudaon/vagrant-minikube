#!/bin/bash

# Dowload page: https://github.com/kubernetes/minikube/releases/

minikube_version="v1.12.1"

echo "--> Installing minikube."

cd /tmp
curl -Lo minikube https://github.com/kubernetes/minikube/releases/download/$minikube_version/minikube-linux-amd64
chmod +x minikube
cp minikube /usr/local/bin && rm minikube
echo "Minikube Version --> $(minikube version)"

echo "--> Minikube successfully installed."
