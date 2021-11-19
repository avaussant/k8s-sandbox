#!/usr/bin/env bash
set -o errexit
set -o pipefail

source $(dirname 0)/scripts/libs.bash
export ACTION=$1
export K8S_VERSION="1.21.1"


nginx_ingress_controller() {
  msg_info "Install Nginx Ingress Controller"
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
  kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s
}

gatekeeper_opa() {
  msg_info "Install Gatekeeper/Opa"
  helm upgrade -i gatekeeper gatekeeper/gatekeeper \
    --version=3.7.0 \
    --wait \
    --atomic \
    --cleanup-on-fail \
    -n gatekeeper-system \
    --create-namespace

  kubectl wait --namespace gatekeeper-system \
  --for=condition=ready pod \
  --selector=control-plane=controller-manager \
  --timeout=90s

  sleep 5

  msg_info "Install Constraints Gatekeeper/Opa"
  helm upgrade -i gatekeeper-constraints config/gatekeeper-constraints \
    --wait \
    --atomic \
    --cleanup-on-fail \
    -n gatekeeper-system

  sleep 5
}

update_master_endpoint() {
  msg_info "Modifying Kubernetes config to point to Kind master node"
  MASTER_IP=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' k8s-sandbox-control-plane)
  sed -i "s/^    server:.*/    server: https:\/\/$MASTER_IP:6443/" $HOME/.kube/config

  chmod -R go-r $HOME/.kube/config

  msg_info "Attach client to kind network"
  docker network connect kind k8s-client

  msg_output "Add helm repo"
  helm repo add stable https://charts.helm.sh/stable
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo update
}

lab_up() {
  msg_info "Create k8s Lab"
  kind create cluster --config config/kind.yml --name k8s-sandbox --image kindest/node:v${K8S_VERSION}

  update_master_endpoint

  msg_output "$(printf %"s\n" && kubectl cluster-info --context kind-k8s-sandbox)"

  nginx_ingress_controller

  gatekeeper_opa

  lab_ready
}

lab_cleanup() {
  msg_error "Lab deletion"
  kind delete cluster --name k8s-sandbox
  msg_error "Delete docker network access"
  docker network disconnect kind k8s-client
  msg_output "Lab deleted"
}

update_kubeconfig() {
  msg_info "Check if we can get kubeconfig"
  mkdir -p $HOME/.kube
  kind get kubeconfig --name=k8s-sandbox >$HOME/.kube/config
  update_master_endpoint
}

test1 (){
  msg_info "Exercice for Ingress"
  kubectl apply -f tests/exo-1/ingress.yaml
  msg_error "what is wrong edit the file tests/exo-1/ingress.yaml and update it"
  msg_output "1 - try from your browser : localhost/foo"
  msg_output "2 - try from your browser : localhost/bar"
  msg_output "3 - Find the error in tests/exo-1/ingress.yaml and relaunch lab --exo1"
  msg_output "4 - Retry from your browser"
}

test2 (){
  msg_info "Exercice for PsP and Admission controller"

  msg_info "Install rules Gatekeeper/Opa"
  helm upgrade -i gatekeeper-rules tests/exo-2/gatekeeper-rules \
    --wait \
    --atomic \
    --cleanup-on-fail \
    -n gatekeeper-system

  msg_info "Try to deploy App with Helm Chart"
  helm upgrade -i simple-server tests/exo-2/simple-server -n exo2 --create-namespace
  kubectl get all -n exo2
  msg_error "Can you check the deployment something goes wrong"
  msg_output "You can try to fix it with mutation :) keep smile"
  msg_output "Crd is your friend"
  msg_output "1 - Find the deployment in namespace exo2"
  msg_output "2 - Find why the deployment is failing in namespace exo2"
  msg_output "3 - Try to fix or find a way to fix it"
  msg_info "Indication - User/group/supplementalGroups might be 1001"
}

test3 (){
  msg_info "Exercice for Operator and CRDs"
  msg_info "Create Istio Operator Namespace"
  kubectl apply -f config/istio-operator/operator-ns.yaml
  msg_info "Install Istio operator"
  helm upgrade -i istio-operator config/istio-operator \
    --atomic \
    --wait \
    --cleanup-on-fail \
    -n istio-operator
  
  msg_info "Install Istio Profile 1.19 inside istio-system ns"
  helm upgrade -i istio-install tests/exo-3/istio-install -n istio-operator

  msg_output "1 - Retrieve CRD list"
  msg_output "2 - Retrieve Istio CRDs"
  msg_output "3 - Retrieve Istio Profile installed"
  msg_output "4 - If needed Edit files tests/exo-3/istio-install/* / Activate auto injection as sidecar and relauch lab --exo3"
  msg_output "5 - Create Namespace exo3 - Add annotations for injection from CRD config"
  msg_output "6 - Create simple deployment/svc/ing and checking injection and envoy sidecar logs - take a look on the template tests/exo-3/tpl-exo3.yaml"
  msg_info "Indication - take a look on the chart tests/exo-3/istio-install"
  msg_info "Indication - Operator is installed on ns istio-operator"
  msg_info "Indication - istiod is installed on ns istio-system"
}

test4 (){
  msg_info "Create k8s Lab for Monitoring - waiting ............"
  if ! kind create cluster --config config/kind.yml --name k8s-sandbox --image kindest/node:v${K8S_VERSION} > /dev/null 2>&1; then
    msg_info "It might be hard to put all in the same cluster :-("
    msg_error "Please delete old lab before and try again with a fresh installation"
  else
    update_master_endpoint
    msg_output "$(printf %"s\n" && kubectl cluster-info --context kind-k8s-sandbox)"
    nginx_ingress_controller
  fi

  msg_info "Exercice for Monitoring"
  msg_info "Install Prometheus Adapter"
  helm upgrade -i prometheus-adapter prometheus-community/prometheus-adapter \
    -f tests/exo-4/prometheus-adapter.yaml \
    --version 2.17.0 \
    --atomic \
    --cleanup-on-fail \
    -n monitoring --create-namespace

  msg_info "Install Prometheus Operator / Stack"
  helm upgrade -i kube-prometheus-stack bitnami/kube-prometheus \
    -f tests/exo-4/kube-prometheus-stack.yaml \
    --version 6.4.1 \
    --atomic \
    --cleanup-on-fail \
    -n monitoring --create-namespace

  msg_info "Install DB for my APP"
  helm upgrade -i my-db tests/exo-4/postgresql \
    -f tests/exo-4/postgresql/pg-values.yaml \
    --atomic \
    --cleanup-on-fail \
    --namespace exo4  \
    --create-namespace

  kubectl wait --namespace exo4 \
    --for=condition=ready pod \
    --selector=app.kubernetes.io/name=my-db \
    --timeout=90s

  msg_info "Install DB metrics exporter for my APP + Rules for Prometheus"
  helm upgrade -i  postgres-exporter tests/exo-4/prometheus-postgres-exporter \
    --atomic \
    --cleanup-on-fail \
    --namespace exo4 \
    --create-namespace \
    -f tests/exo-4/prometheus-postgres-exporter/pg-exporter-values.yaml \
    -f tests/exo-4/prometheus-postgres-exporter/prom-pg-rules.yaml

  msg_info "Ingress for Prometheus"
  kubectl apply -f tests/exo-4/prometheus-ingress.yaml
  
  msg_output "1 - try from your browser : localhost"
  msg_output "2 - Look the rules in place"
  msg_output "3 - Create Custom rules with metrics coming from pgsql exporter"
  msg_output "4 - If possible crash the db to get firing status with your Rule"
  msg_info "Indication - You can take a look on the file tests/exo-4/prometheus-postgres-exporter/prom-pg-rules.yaml"
  msg_info "Indication - for direct access to db try to follow the NOTE.txt"

}
  # msg_info "Install small elastic deployment"

##########################################
# Main function
##########################################
help_script="options :
                -h|--help
             or --up
             or --down
             or --kubeconfig
             or --exo1
             or --exo2
             or --exo3
             or --exo4
             blablabla"

[ -z "$ACTION" ] && msg_error "${help_script}" && exit 1
while [[ "$#" -gt 0 ]]; do
  case $1 in
  --up) lab_up ;;
  --down) lab_cleanup ;;
  --kubeconfig) update_kubeconfig ;;
  --exo1) test1 ;;
  --exo2) test2 ;;
  --exo3) test3 ;;
  --exo4) test4 ;;
  -h | --help) msg_info "${help_script}" ;;
  *)
    msg_error "Unknown parameter passed: $1"
    msg_error "${help_script}"
    exit 1
    ;;
  esac
  shift
done
