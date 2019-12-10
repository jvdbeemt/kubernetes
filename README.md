# Prequisits
* Add `127.0.0.0/8` and `harbor.k8s-local.io` to the list of insecure registries and restart docker

# Installation
```
# Installing fluxctl
brew install helm fluxctl argoproj/tap/argo

# Setting up all deployments
bin/setup.sh

# Retrieving secrets:
bin/secrets.sh
```

## Configuration of harbor
To setup harbor for the demo project:
```
bin/setup_harbor.sh
```
* Demo user: `demo` with password `Demodemo0`
* Project: `demo`
* Administrator account `admin` credentials can be found in code

# Components
* Prometheus **(Metrics)**
* Grafana    **(Dashboards)**
* Argo       **(Workflows)**
* MinIO      **(S3 like object store)**
* Harbor     **(Helm & Docker registry)**
* Flux **(without helm)**
* Demo app   **(Static HTML on nginx alpine container)**
* Kubernetes Dashboard
* Nginx Ingress

# Available URLS:

* [Kubernetes dashboard](https://dashboard.k8s-local.io)
* [Grafana](https://monitoring.k8s-local.io)
* [Argo workflows](https://argo.k8s-local.io)
* [MinIO](https://minio.k8s-local.io)
* [Harbor](https://harbor.k8s-local.io)
* [Demo - stable](https://demo.k8s-local.io)
* [Demo - pre release](https://demo.k8s-local.io/banana)


# Todo
* Add helm operator in flux
* Automate demo harbor installation
