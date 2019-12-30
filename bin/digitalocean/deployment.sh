#!/bin/bash

set -o errno
set -o nounset

env=$1

if [ "$#" -ne 1 ]; then
    echo "No environment specified."
    exit 1
fi

# environments to an array
envs=($env)

echo "$KUBERNETES_CLUSTER_CERTIFICATE" | base64 --decode > cert.crt
for e in ${envs[@]}; do
    kubectl --kubeconfig=/dev/null --server=$KUBERNETES_SERVER --certificate-authority=cert.crt --token=$KUBERNETES_TOKEN apply -f kubernetes/digitalocean/${e}/
done
