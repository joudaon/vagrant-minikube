#!/bin/bash

# Dowload page: https://skaffold.dev/docs/install/

echo "--> Installing skaffold."

cd /tmp
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64
install skaffold /usr/local/bin/
rm skaffold
echo "skaffold Version --> $(skaffold version)"

echo "--> skaffold successfully installed."