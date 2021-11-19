#!/usr/bin/env bash
set -o errexit
set -o pipefail

source $(dirname 0)/scripts/libs.bash
export ACTION=$1
export K8S_VERSION="1.21.1"

update_master_endpoint() {
  msg_info "Modifying Kubernetes config to point to Kind master node"
  MASTER_IP=$(docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' k8s-sandbox-control-plane)
  sed -i "s/^    server:.*/    server: https:\/\/$MASTER_IP:6443/" $HOME/.kube/config

  msg_info "Attach client to kind network"
  docker network connect kind k8s-client
}

lab_up() {
  msg_info "Create k8s Lab"
  kind create cluster --config config/kind.yml --name k8s-sandbox --image kindest/node:v${K8S_VERSION}

  update_master_endpoint

  msg_output "$(printf %"s\n" && kubectl cluster-info --context kind-k8s-sandbox)"

  msg_output "Add helm repo"
  helm repo add stable https://charts.helm.sh/stable
  helm repo add bitnami https://charts.bitnami.com/bitnami
  helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts
  helm repo update

  msg_info "Install Nginx Ingress Controller"
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
  kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

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
  msg_info "Exercice for Ingress - There is 1 error"
  kubectl apply -f tests/exo-1/ingress.yaml
  msg_output "try from your browser : localhost/foo"
  msg_output "try from your browser : localhost/bar"
  msg_error "what is wrong edit the file tests/exo-1/ingress.yaml and update it"
}

test2 (){
  msg_info "Exercice for PsP and Admission controller - There is 1 error"
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
  msg_info "You can try to fix it with mutation :) keep smile"
}

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
             blablabla"

[ -z "$ACTION" ] && msg_error "${help_script}" && exit 1
while [[ "$#" -gt 0 ]]; do
  case $1 in
  --up) lab_up ;;
  --down) lab_cleanup ;;
  --kubeconfig) update_kubeconfig ;;
  --exo1) test1 ;;
  --exo2) test2 ;;
  -h | --help) msg_info "${help_script}" ;;
  *)
    msg_error "Unknown parameter passed: $1"
    msg_error "${help_script}"
    exit 1
    ;;
  esac
  shift
done
