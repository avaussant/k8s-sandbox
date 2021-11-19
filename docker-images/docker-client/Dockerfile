# build kustomize
FROM golang:1.17-alpine as builder-kustomize
ENV GO111MODULE=on
RUN apk --no-cache add gcc git musl-dev
RUN go get sigs.k8s.io/kustomize/kustomize/v4@v4.4.0
RUN /go/bin/kustomize version

FROM alpine:3.9 as k8s-sandbox

RUN apk --no-cache add \
    bash \
    curl \
    docker \
    git \
    openssl \
    shadow \
    vim \
    ncurses \
    wget

RUN groupadd -r k8s-sandbox \
             -g 777 && \
    useradd -c "k8s-sandbox runner account" \
            -g k8s-sandbox \
            -u 777 \
            -m \
            -r \
            k8s-sandbox && \
    usermod -aG docker k8s-sandbox


ENV K9S_VERSION=0.25.3
RUN echo "install k9s" && \
    curl -sf -LO https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_x86_64.tar.gz && \
    tar -zxvf k9s_Linux_x86_64.tar.gz  && \
    mv k9s /usr/local/bin/k9s && \
    chmod +x /usr/local/bin/k9s && \
    rm -rf k9s_Linux_x86_64.tar.gz linux-amd64 LICENSE README

ENV YQ_VERSION=3.4.1
RUN echo "install yq" && \
    curl --silent --fail -L https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64 -o /usr/local/bin/yq && \
    chmod +x /usr/local/bin/yq

ENV JQ_VERSION=1.6
RUN echo "install jq" && \
    curl --silent --fail -L https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 -o /usr/local/bin/jq && \
    chmod +x /usr/local/bin/jq

# https://kubernetes.io/docs/tasks/kubectl/install/
# latest stable kubectl: curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt
ENV KUBECTL_VERSION=v1.20.12
RUN echo "install kubectl" && \
    curl --silent --fail -L https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

ENV HELM_VERSION=v3.6.2
RUN echo "install helm" && \
    curl -sf -LO https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm && \
    rm -rf helm-${HELM_VERSION}-linux-amd64.tar.gz linux-amd64

COPY --from=builder-kustomize /go/bin/kustomize /usr/local/bin/

# k14s ytt
ENV YTT_VERSION=0.37.0
RUN echo "install ytt" && \
    curl --silent --fail -L -o /usr/local/bin/ytt https://github.com/k14s/ytt/releases/download/v${YTT_VERSION}/ytt-linux-amd64 && \
    chmod +x /usr/local/bin/ytt

# k14s kapp
ENV KAPP_VERSION=0.42.0
RUN echo "install kapp" && \
    curl --silent --fail -L -o /usr/local/bin/kapp https://github.com/k14s/kapp/releases/download/v${KAPP_VERSION}/kapp-linux-amd64 && \
    chmod +x /usr/local/bin/kapp

RUN echo "install kubectx" && \
    curl --silent --fail -L https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx -o /usr/local/bin/kubectx && \
    chmod +x /usr/local/bin/kubectx

RUN echo "install kubens" && \
    curl --silent --fail -L https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens -o /usr/local/bin/kubens && \
    chmod +x /usr/local/bin/kubens

RUN echo "install kube-ps1 for Developer Usage" && \
    curl --silent --fail -L https://raw.githubusercontent.com/jonmosco/kube-ps1/master/kube-ps1.sh -o /usr/local/bin/kube-ps1.sh && \
    chmod +x /usr/local/bin/kube-ps1.sh

ENV KIND_VERSION=0.11.1
RUN echo "install kind" && \
    curl --silent --fail -L https://kind.sigs.k8s.io/dl/v${KIND_VERSION}/kind-linux-amd64 -o /usr/local/bin/kind && \
    chmod +x /usr/local/bin/kind

ENV PATH="${PATH}:/root"

ENV HELM_DIFF_PLUGIN_VERSION=v3.1.3
RUN /usr/local/bin/helm plugin install https://github.com/databus23/helm-diff --version ${HELM_DIFF_PLUGIN_VERSION}

RUN git config --global credential.helper store
COPY entrypoint.sh /usr/local/bin/
COPY bashrc /root/.bashrc

ENTRYPOINT ["/bin/bash", "/usr/local/bin/entrypoint.sh"]
