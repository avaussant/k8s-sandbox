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
```

## Tests

1. _**Ingresses**_

<details><summary>lab --exo1</summary>

- How to debug an ingress, what can be wrong ?
    - 2 services
    - 2 pods
    - 2 urls
    - 1 error

Try to find the issue fix it and relaunch the script 
</details>


```console
[ OUT ] ====================================================
[ OUT ]  DATE : 2020-02-11_11:14:32
[ OUT ]  Repo elastic existing in your helm config
[ OUT ] ====================================================
[INFOS]
[INFOS] ====================================================
[INFOS]  DATE : 2020-02-11_11:14:32
[INFOS]  Starting elasticsearch deployment
```

## How to update ELK configs

1. For ealsticsearch - Go to [es-values](elasticsearch/values.yaml)

2. For kibana  - Go to [es-values](kibana/values.yaml)

After modification you can just use the command **aps-elk.sh -u**
