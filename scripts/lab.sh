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

##########################################
# Main function
##########################################
help_script="options :
                -h|--help
             or --up
             or --down
             or --kubeconfig
             blablabla"

[ -z "$ACTION" ] && msg_error "${help_script}" && exit 1
while [[ "$#" -gt 0 ]]; do
  case $1 in
  --up) lab_up ;;
  --down) lab_cleanup ;;
  --kubeconfig) update_kubeconfig ;;
  -h | --help) msg_info "${help_script}" ;;
  *)
    msg_error "Unknown parameter passed: $1"
    msg_error "${help_script}"
    exit 1
    ;;
  esac
  shift
done
