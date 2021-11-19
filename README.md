# k8s-sandbox - How to play with Kubernetes for learning
How to play with Kubernetes + debugging

## Prerequisites tools

- docker - https://docs.docker.com/install/linux/docker-ce/binaries/
- Prefered - MacOs or Linux (not tested on wsl)

## Usage

```bash
$ git clone https://github.com/avaussant/k8s-sandbox.git
$ cd k8s-sandbox
$ ./launch
    ===========================
    Welcome to our lab

    Please execute : lab

    ===========================

# Try lab cli
$ lab 

[ WARN ]
[ WARN ] ====================================================
[ WARN ]  DATE : 2021-11-19_21:46:57
[ WARN ]  options :
                -h|--help
             or --up
             or --down
             or --kubeconfig
             or --exo1
             or --exo2
             or --exo3
             or --exo4
             blablabla
[ WARN ] ====================================================
```

<details><summary>lab --up</summary>

```console
[workspace ]# lab --up
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:47:01
[INFOS]  Create k8s Lab
[INFOS] ====================================================
Creating cluster "k8s-sandbox" ...
 ✓ Ensuring node image (kindest/node:v1.21.1) 🖼
 ✓ Preparing nodes 📦 📦 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-k8s-sandbox"
You can now use your cluster with:

kubectl cluster-info --context kind-k8s-sandbox

Thanks for using kind! 😊
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:48:50
[INFOS]  Modifying Kubernetes config to point to Kind master node
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:48:51
[INFOS]  Attach client to kind network
[INFOS] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_21:48:51
[ OUT ]  Add helm repo
[ OUT ] ====================================================
"stable" has been added to your repositories
"bitnami" has been added to your repositories
"gatekeeper" has been added to your repositories
"prometheus-community" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "gatekeeper" chart repository
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "stable" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_21:49:19
[ OUT ]
Kubernetes control plane is running at https://172.18.0.4:6443
CoreDNS is running at https://172.18.0.4:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
[ OUT ] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:49:19
[INFOS]  Install Nginx Ingress Controller
[INFOS] ====================================================
namespace/ingress-nginx created
serviceaccount/ingress-nginx created
configmap/ingress-nginx-controller created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
service/ingress-nginx-controller-admission created
service/ingress-nginx-controller created
deployment.apps/ingress-nginx-controller created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
serviceaccount/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
pod/ingress-nginx-controller-8566f757cc-4rzgn condition met
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:50:00
[INFOS]  Install Gatekeeper/Opa
[INFOS] ====================================================
Release "gatekeeper" does not exist. Installing it now.
W1119 21:50:03.051388     892 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 21:50:11.453208     892 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
NAME: gatekeeper
LAST DEPLOYED: Fri Nov 19 21:50:02 2021
NAMESPACE: gatekeeper-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
pod/gatekeeper-controller-manager-795447c446-j4gs8 condition met
pod/gatekeeper-controller-manager-795447c446-lp5mj condition met
pod/gatekeeper-controller-manager-795447c446-r5ffk condition met
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:50:52
[INFOS]  Install Constraints Gatekeeper/Opa
[INFOS] ====================================================
Release "gatekeeper-constraints" does not exist. Installing it now.
NAME: gatekeeper-constraints
LAST DEPLOYED: Fri Nov 19 21:50:53 2021
NAMESPACE: gatekeeper-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:51:01
[INFOS]
[INFOS]  Lab is ready to be used
[INFOS]  Tools Available:
[INFOS]
[INFOS]  - k9s
[INFOS]  - kubectl
[INFOS]  - helm
[INFOS]  - kubens
[INFOS]  - kind
[INFOS]  - yq
[INFOS]  - jq
[INFOS]
[INFOS] ====================================================
[INFOS]
NAMESPACE            NAME                                                    READY   STATUS      RESTARTS   AGE
gatekeeper-system    pod/gatekeeper-audit-5bf8484757-fzbld                   1/1     Running     0          49s
gatekeeper-system    pod/gatekeeper-controller-manager-795447c446-j4gs8      1/1     Running     0          47s
gatekeeper-system    pod/gatekeeper-controller-manager-795447c446-lp5mj      1/1     Running     0          47s
gatekeeper-system    pod/gatekeeper-controller-manager-795447c446-r5ffk      1/1     Running     0          49s
ingress-nginx        pod/ingress-nginx-admission-create-ttjzc                0/1     Completed   0          100s
ingress-nginx        pod/ingress-nginx-admission-patch-dz5mn                 0/1     Completed   0          100s
ingress-nginx        pod/ingress-nginx-controller-8566f757cc-4rzgn           1/1     Running     0          101s
kube-system          pod/coredns-558bd4d5db-cfqgq                            1/1     Running     0          2m32s
kube-system          pod/coredns-558bd4d5db-tg5nt                            1/1     Running     0          2m32s
kube-system          pod/etcd-k8s-sandbox-control-plane                      1/1     Running     0          2m46s
kube-system          pod/kindnet-4jdtn                                       1/1     Running     0          2m32s
kube-system          pod/kindnet-brkmh                                       1/1     Running     0          2m12s
kube-system          pod/kindnet-pn6qb                                       1/1     Running     0          2m13s
kube-system          pod/kindnet-sgxz5                                       1/1     Running     0          2m14s
kube-system          pod/kube-apiserver-k8s-sandbox-control-plane            1/1     Running     0          2m46s
kube-system          pod/kube-controller-manager-k8s-sandbox-control-plane   1/1     Running     0          2m46s
kube-system          pod/kube-proxy-j4mt4                                    1/1     Running     0          2m13s
kube-system          pod/kube-proxy-jbpch                                    1/1     Running     0          2m32s
kube-system          pod/kube-proxy-t5pwn                                    1/1     Running     0          2m14s
kube-system          pod/kube-proxy-tvqm7                                    1/1     Running     0          2m12s
kube-system          pod/kube-scheduler-k8s-sandbox-control-plane            1/1     Running     0          2m46s
local-path-storage   pod/local-path-provisioner-85494db59d-t42rd             1/1     Running     0          2m32s

NAMESPACE           NAME                                         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
default             service/kubernetes                           ClusterIP   10.96.0.1       <none>        443/TCP                      2m50s
gatekeeper-system   service/gatekeeper-webhook-service           ClusterIP   10.96.126.99    <none>        443/TCP                      51s
ingress-nginx       service/ingress-nginx-controller             NodePort    10.96.34.126    <none>        80:30566/TCP,443:31781/TCP   102s
ingress-nginx       service/ingress-nginx-controller-admission   ClusterIP   10.96.239.135   <none>        443/TCP                      102s
kube-system         service/kube-dns                             ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP       2m48s

NAMESPACE     NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-system   daemonset.apps/kindnet      4         4         4       4            4           <none>                   2m45s
kube-system   daemonset.apps/kube-proxy   4         4         4       4            4           kubernetes.io/os=linux   2m48s

NAMESPACE            NAME                                            READY   UP-TO-DATE   AVAILABLE   AGE
gatekeeper-system    deployment.apps/gatekeeper-audit                1/1     1            1           51s
gatekeeper-system    deployment.apps/gatekeeper-controller-manager   3/3     3            3           51s
ingress-nginx        deployment.apps/ingress-nginx-controller        1/1     1            1           102s
kube-system          deployment.apps/coredns                         2/2     2            2           2m48s
local-path-storage   deployment.apps/local-path-provisioner          1/1     1            1           2m44s

NAMESPACE            NAME                                                       DESIRED   CURRENT   READY   AGE
gatekeeper-system    replicaset.apps/gatekeeper-audit-5bf8484757                1         1         1       51s
gatekeeper-system    replicaset.apps/gatekeeper-controller-manager-795447c446   3         3         3       51s
ingress-nginx        replicaset.apps/ingress-nginx-controller-8566f757cc        1         1         1       102s
kube-system          replicaset.apps/coredns-558bd4d5db                         2         2         2       2m34s
local-path-storage   replicaset.apps/local-path-provisioner-85494db59d          1         1         1       2m34s

NAMESPACE       NAME                                       COMPLETIONS   DURATION   AGE
ingress-nginx   job.batch/ingress-nginx-admission-create   1/1           7s         101s
ingress-nginx   job.batch/ingress-nginx-admission-patch    1/1           7s         101s
```
</details>

<details><summary>lab --down</summary>

```console
[workspace (⎈ |kind-k8s-sandbox:default)]# lab --down
[ WARN ]
[ WARN ] ====================================================
[ WARN ]  DATE : 2021-11-19_23:17:17
[ WARN ]  Lab deletion
[ WARN ] ====================================================
Deleting cluster "k8s-sandbox" ...
[ WARN ]
[ WARN ] ====================================================
[ WARN ]  DATE : 2021-11-19_23:17:25
[ WARN ]  Delete docker network access
[ WARN ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_23:17:25
[ OUT ]  Lab deleted
[ OUT ] ====================================================
```
</details>

<details><summary>lab --kubeconfig</summary>

```console
[workspace ]# lab --kubeconfig
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_23:13:45
[INFOS]  Check if we can get kubeconfig
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_23:13:46
[INFOS]  Modifying Kubernetes config to point to Kind master node
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_23:13:46
[INFOS]  Attach client to kind network
[INFOS] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_23:13:46
[ OUT ]  Add helm repo
[ OUT ] ====================================================
"stable" has been added to your repositories
"bitnami" has been added to your repositories
"gatekeeper" has been added to your repositories
"prometheus-community" has been added to your repositories
"elastic" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "gatekeeper" chart repository
...Successfully got an update from the "elastic" chart repository
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "stable" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
```
</details>

## Tests

1. _**Ingresses**_


- How to debug an ingress, what can be wrong ?
    - 2 services
    - 2 pods
    - 2 urls
    - 1 error

Try to find the issue fix it and relaunch the script 

<details><summary>lab --exo1</summary>

```console
[workspace (⎈ |kind-k8s-sandbox:default)]# lab --exo1
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:54:19
[INFOS]  Exercice for Ingress
[INFOS] ====================================================
namespace/exo1 created
pod/foo-app created
service/foo-service created
pod/bar-app created
service/bar-service created
ingress.networking.k8s.io/example-ingress created
[ WARN ]
[ WARN ] ====================================================
[ WARN ]  DATE : 2021-11-19_21:54:20
[ WARN ]  what is wrong edit the file tests/exo-1/ingress.yaml and update it
[ WARN ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_21:54:20
[ OUT ]  1 - try from your browser : localhost/foo
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_21:54:20
[ OUT ]  2 - try from your browser : localhost/bar
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_21:54:20
[ OUT ]  3 - Find the error in tests/exo-1/ingress.yaml and relaunch lab --exo1
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_21:54:20
[ OUT ]  4 - Retry from your browser
[ OUT ] ====================================================
```
</details>

2. _**AdmissionController - OPA - PsP**_

- How to debug a bad deployment not hardenized, what can be wrong ?
    - 1 service
    - 1 pod
    - 1 ingress
    - 9 errors

<details><summary>lab --exo2</summary>

```console
[workspace (⎈ |kind-k8s-sandbox:default)]# lab --exo2
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:59:56
[INFOS]  Exercice for PsP and Admission controller
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:59:56
[INFOS]  Install rules Gatekeeper/Opa
[INFOS] ====================================================
Release "gatekeeper-rules" does not exist. Installing it now.
NAME: gatekeeper-rules
LAST DEPLOYED: Fri Nov 19 21:59:56 2021
NAMESPACE: gatekeeper-system
STATUS: deployed
REVISION: 1
TEST SUITE: None
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_21:59:57
[INFOS]  Try to deploy App with Helm Chart
[INFOS] ====================================================
Release "simple-server" does not exist. Installing it now.
W1119 21:59:58.919041     995 warnings.go:70] extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
W1119 21:59:59.664547     995 warnings.go:70] extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
NAME: simple-server
LAST DEPLOYED: Fri Nov 19 21:59:58 2021
NAMESPACE: exo2
STATUS: deployed
REVISION: 1
TEST SUITE: None
NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/simple-server   ClusterIP   10.96.216.223   <none>        80/TCP    1s

NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/simple-server   0/1     0            0           1s

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/simple-server-6d48687ff5   1         0         0       1s
[ WARN ]
[ WARN ] ====================================================
[ WARN ]  DATE : 2021-11-19_22:00:00
[ WARN ]  Can you check the deployment something goes wrong
[ WARN ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:00:00
[ OUT ]  You can try to fix it with mutation :) keep smile
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:00:00
[ OUT ]  Crd is your friend
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:00:00
[ OUT ]  1 - Find the deployment in namespace exo2
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:00:00
[ OUT ]  2 - Find why the deployment is failing in namespace exo2
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:00:00
[ OUT ]  3 - Try to fix or find a way to fix it
[ OUT ] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:00:00
[INFOS]  Indication - User/group/supplementalGroups might be 1001
[INFOS] ====================================================
```

</details>


3. _**Istio - Envoy - Annotations**_

- How to debug a bad Istio Profile with no injection, what can be wrong ?
- Could create a deployment to test it ?
    - 1 Operator
    - 1 Profile
    - 1 service
    - 1 pod
    - 1 ingress
    - 3 errors

<details><summary>lab --exo3</summary>

```console
[workspace (⎈ |kind-k8s-sandbox:default)]# lab --exo3
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:06:43
[INFOS]  Exercice for Operator and CRDs
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:06:43
[INFOS]  Create Istio Operator Namespace
[INFOS] ====================================================
namespace/istio-operator created
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:06:43
[INFOS]  Install Istio operator
[INFOS] ====================================================
Release "istio-operator" does not exist. Installing it now.
NAME: istio-operator
LAST DEPLOYED: Fri Nov 19 22:06:43 2021
NAMESPACE: istio-operator
STATUS: deployed
REVISION: 1
TEST SUITE: None
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:06:58
[INFOS]  Install Istio Profile 1.19 inside istio-system ns
[INFOS] ====================================================
Release "istio-install" does not exist. Installing it now.
NAME: istio-install
LAST DEPLOYED: Fri Nov 19 22:06:59 2021
NAMESPACE: istio-operator
STATUS: deployed
REVISION: 1
TEST SUITE: None
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:06:59
[ OUT ]  1 - Retrieve CRD list
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:06:59
[ OUT ]  2 - Retrieve Istio CRDs
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:06:59
[ OUT ]  3 - Retrieve Istio Profile installed
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:06:59
[ OUT ]  4 - If needed Edit files tests/exo-3/istio-install/* / Activate auto injection as sidecar and relauch lab --exo3
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:06:59
[ OUT ]  5 - Create Namespace exo3 - Add annotations for injection from CRD config
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:06:59
[ OUT ]  6 - Create simple deployment/svc/ing and checking injection and envoy sidecar logs - take a look on the template tests/exo-3/tpl-exo3.yaml
[ OUT ] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:06:59
[INFOS]  Indication - take a look on the chart tests/exo-3/istio-install
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:06:59
[INFOS]  Indication - Operator is installed on ns istio-operator
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:06:59
[INFOS]  Indication - istiod is installed on ns istio-system
[INFOS] ====================================================
```

</details>

4. _**Prometheus & CRDs**_

- How to monitor a deployment with custom rules, how it's working ?
    - 1 deployment
    - 1 exporter
    - 1 rules

<details><summary>lab --exo4</summary>

```console
[workspace (⎈ |N/A:default)]# lab --exo4
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:47:26
[INFOS]  Create k8s Lab for Monitoring - waiting ............
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:48:44
[INFOS]  Modifying Kubernetes config to point to Kind master node
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:48:44
[INFOS]  Attach client to kind network
[INFOS] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:48:44
[ OUT ]  Add helm repo
[ OUT ] ====================================================
"stable" already exists with the same configuration, skipping
"bitnami" already exists with the same configuration, skipping
"gatekeeper" already exists with the same configuration, skipping
"prometheus-community" already exists with the same configuration, skipping
"elastic" has been added to your repositories
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "gatekeeper" chart repository
...Successfully got an update from the "elastic" chart repository
...Successfully got an update from the "prometheus-community" chart repository
...Successfully got an update from the "stable" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:48:56
[ OUT ]
Kubernetes control plane is running at https://172.18.0.5:6443
CoreDNS is running at https://172.18.0.5:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
[ OUT ] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:48:56
[INFOS]  Install Nginx Ingress Controller
[INFOS] ====================================================
namespace/ingress-nginx created
serviceaccount/ingress-nginx created
configmap/ingress-nginx-controller created
clusterrole.rbac.authorization.k8s.io/ingress-nginx created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx created
role.rbac.authorization.k8s.io/ingress-nginx created
rolebinding.rbac.authorization.k8s.io/ingress-nginx created
service/ingress-nginx-controller-admission created
service/ingress-nginx-controller created
deployment.apps/ingress-nginx-controller created
ingressclass.networking.k8s.io/nginx created
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission created
serviceaccount/ingress-nginx-admission created
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission created
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
role.rbac.authorization.k8s.io/ingress-nginx-admission created
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission created
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
pod/ingress-nginx-controller-8566f757cc-v9gd4 condition met
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:49:37
[INFOS]  Exercice for Monitoring
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:49:37
[INFOS]  Install Prometheus Adapter
[INFOS] ====================================================
Release "prometheus-adapter" does not exist. Installing it now.
W1119 22:49:39.582884    5065 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:49:39.795779    5065 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
NAME: prometheus-adapter
LAST DEPLOYED: Fri Nov 19 22:49:39 2021
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
prometheus-adapter has been deployed.
In a few minutes you should be able to list metrics using the following command(s):

  kubectl get --raw /apis/metrics.k8s.io/v1beta1
  kubectl get --raw /apis/custom.metrics.k8s.io/v1beta1
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:50:23
[INFOS]  Install Prometheus Operator / Stack
[INFOS] ====================================================
Release "kube-prometheus-stack" does not exist. Installing it now.
W1119 22:50:38.742378    5073 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:50:38.747162    5073 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:50:38.752377    5073 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:50:38.755308    5073 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:50:39.582313    5073 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:50:39.588727    5073 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:50:39.590012    5073 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:50:39.591670    5073 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
NAME: kube-prometheus-stack
LAST DEPLOYED: Fri Nov 19 22:50:37 2021
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: kube-prometheus
CHART VERSION: 6.4.1
APP VERSION: 0.52.1

** Please be patient while the chart is being deployed **

Watch the Prometheus Operator Deployment status using the command:

    kubectl get deploy -w --namespace monitoring -l app.kubernetes.io/name=kube-prometheus-operator,app.kubernetes.io/instance=kube-prometheus-stack

Watch the Prometheus StatefulSet status using the command:

    kubectl get sts -w --namespace monitoring -l app.kubernetes.io/name=kube-prometheus-prometheus,app.kubernetes.io/instance=kube-prometheus-stack

Prometheus can be accessed via port "9090" on the following DNS name from within your cluster:

    kube-prometheus-stack-prometheus.monitoring.svc.cluster.local

To access Prometheus from outside the cluster execute the following commands:

    echo "Prometheus URL: http://127.0.0.1:9090/"
    kubectl port-forward --namespace monitoring svc/kube-prometheus-stack-prometheus 9090:9090
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:51:51
[INFOS]  Install DB for my APP
[INFOS] ====================================================
Release "my-db" does not exist. Installing it now.
W1119 22:51:52.684673    5079 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:51:52.857330    5079 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
NAME: my-db
LAST DEPLOYED: Fri Nov 19 22:51:52 2021
NAMESPACE: exo4
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

PostgreSQL can be accessed via port 5432 on the following DNS name from within your cluster:

    my-db.exo4.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace exo4 my-db -o jsonpath="{.data.postgresql-password}" | base64 --decode)

To connect to your database run the following command:

    kubectl run my-db-client --rm --tty -i --restart='Never' --namespace exo4 --image docker.io/bitnami/postgresql:11.9.0-debian-10-r48 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host my-db -U postgres -d postgres -p 5432
To connect to your database from outside the cluster execute the following commands:

    kubectl port-forward --namespace exo4 svc/my-db 5432:5432 &
    PGPASSWORD="$POSTGRES_PASSWORD" psql --host 127.0.0.1 -U postgres -d postgres -p 5432
pod/my-db-0 condition met
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:52:29
[INFOS]  Install DB metrics exporter for my APP + Rules for Prometheus
[INFOS] ====================================================
Release "postgres-exporter" does not exist. Installing it now.
W1119 22:52:30.480437    5093 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:52:30.504458    5093 warnings.go:70] rbac.authorization.k8s.io/v1beta1 Role is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 Role
W1119 22:52:30.523230    5093 warnings.go:70] rbac.authorization.k8s.io/v1beta1 RoleBinding is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 RoleBinding
W1119 22:52:30.648670    5093 warnings.go:70] policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
W1119 22:52:30.752414    5093 warnings.go:70] rbac.authorization.k8s.io/v1beta1 Role is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 Role
W1119 22:52:30.780903    5093 warnings.go:70] rbac.authorization.k8s.io/v1beta1 RoleBinding is deprecated in v1.17+, unavailable in v1.22+; use rbac.authorization.k8s.io/v1 RoleBinding
NAME: postgres-exporter
LAST DEPLOYED: Fri Nov 19 22:52:30 2021
NAMESPACE: exo4
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
  export POD_NAME=$(kubectl get pods --namespace exo4 -l "app=postgres-exporter,release=postgres-exporter" -o jsonpath="{.items[0].metadata.name}")
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl port-forward $POD_NAME 8080:80
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:52:41
[INFOS]  Ingress for Prometheus
[INFOS] ====================================================
ingress.networking.k8s.io/kube-prometheus-stack-prometheus created
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:52:42
[ OUT ]  1 - try from your browser : localhost
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:52:42
[ OUT ]  2 - Look the rules in place
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:52:42
[ OUT ]  3 - Create Custom rules with metrics coming from pgsql exporter
[ OUT ] ====================================================
[ OUT ]
[ OUT ] ====================================================
[ OUT ]  DATE : 2021-11-19_22:52:42
[ OUT ]  4 - If possible crash the db to get firing status with your Rule
[ OUT ] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:52:42
[INFOS]  Indication - You can take a look on the file tests/exo-4/prometheus-postgres-exporter/prom-pg-rules.yaml
[INFOS] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2021-11-19_22:52:42
[INFOS]  Indication - for direct access to db try to follow the NOTE.txt
[INFOS] ====================================================    
```

</details>