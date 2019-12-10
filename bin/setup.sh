#!/bin/bash
keyFile="${HOME}/.ssh/ci_key_rsa"
if [ ! -e ${keyFile} ]; then
  cat /dev/zero | ssh-keygen -t rsa -b 4096 -f ${keyFile} -q -C "ci_key_rsa" -N ""
fi

projects=(
ingress
dashboard
demo
flux
argo
metrics-server
)

for project in ${projects[@]}; do
  echo "[INFO] Creating namespace for project: ${project}"
  kubectl apply -f k8s/${project}/namespace.yaml || echo "No namespace file found"

  echo "[INFO] Deploying project: ${project}"
  kubectl apply -f k8s/${project}
  echo ""
done

charts=(
prometheus
grafana
)

kubectl create namespace monitoring || echo "Already exists"
for chart in ${charts[@]}; do
  helm install monitoring-${chart} charts/${chart} --namespace monitoring || \
  helm upgrade monitoring-${chart} charts/${chart} --namespace monitoring
done

helm install argo-minio charts/minio/ --namespace argo || \
  helm upgrade argo-minio charts/minio/ --namespace argo

kubectl create namespace harbor || echo "Already exists"
helm install harbor charts/harbor/ --namespace harbor || \
  helm upgrade harbor charts/harbor/ --namespace harbor

namespaces=(
flux
demo
argo
)
for namespace in ${namespaces[@]}; do
  kubectl create secret docker-registry regcred \
    --docker-server=harbor.k8s-local.io \
    --docker-username=demo \
    --docker-password=Demodemo0 \
    --docker-email=demo@k8s-local.io \
    --namespace ${namespace}

  kubectl create secret generic ci-key-rsa \
    --from-file=identity=${keyFile} \
    --from-file=id_rsa=${keyFile} \
    --from-file=id_rsa.ipub=${keyFile}.pub \
    --namespace ${namespace}
done

source bin/update_hosts.sh
source bin/secrets.sh
