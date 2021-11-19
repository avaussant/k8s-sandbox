# istio-operator

![Version: 1.0.2](https://img.shields.io/badge/Version-1.0.2-informational?style=flat-square) ![AppVersion: 1.9.3](https://img.shields.io/badge/AppVersion-1.9.3-informational?style=flat-square)

Helm chart for deploying Istio operator

## Source Code

* <http://github.com/istio/istio/operator>

## Derivation from Official chart

* Adding secret template for pulling down from _harbor.gitops.apirs.net/dockerhub_ [(template for secret file)](templates/istio-secret.yaml)

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| hub | string | `"harbor.gitops.apirs.net/dockerhub/istio"` | Where is the image |
| imageCredentials.password | string | `""` | Robot account password - `token` |
| imageCredentials.registry | string | `"https://harbor.gitops.apirs.net"` | Registry Url |
| imageCredentials.username | string | `"robot$...."` | Robot account username |
| imagePullSecrets | string | `"istio-dh-pull"` | Secret name for creation |
| istioNamespace | string | `"istio-system"` | Namespace targeted for istiod installation |
| operatorNamespace | string | `"istio-operator"` | Namespace targeted for istio-operator installation |
| tag | string | `"1.9.3"` | Docker image Tag |
