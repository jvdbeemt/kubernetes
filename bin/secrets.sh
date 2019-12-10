#!/bin/sh
keyFile="${HOME}/.ssh/ci_key_rsa.pub"

echo "[Dashboard]"
echo "  Kubernetes dashboard token:"
kubectl get secret -n kube-system | grep k8sadmin | cut -d " " -f1 | xargs -n 1 | xargs kubectl get secret  -o 'jsonpath={.data.token}' -n kube-system | base64 --decode
echo ""
echo "[Flux]"
echo "  Flux public key:
$(cat ${keyFile})
"
echo "[Grafana]"
echo "  Graphana username: admin"
echo "  Graphana password: $(kubectl get secret --namespace monitoring monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode)"
echo ""
echo "[Minio]"
echo "  Minio access key: $(kubectl get secret --namespace argo argo-minio -o jsonpath="{.data.accesskey}" | base64 --decode)"
echo "  Minio secret key: $(kubectl get secret --namespace argo argo-minio -o jsonpath="{.data.secretkey}" | base64 --decode)"
echo ""
echo "[Harbor]"
echo "  Admin user: admin"
echo "  Password: IbwvebaSuhhN5J5vCKqeJAj85eufb3"
