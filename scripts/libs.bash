#!/usr/bin/env bash
# set -x
set -o errexit
set -o pipefail
###########################################
# Screen function
###########################################
RED="\e[31;1m%s\n"
YELLOW="\e[33;1m%s\n"
GREEN="\e[32;1m%s\n"
NOCOLOR='\033[0m' # No Color

function msg_info() {
    printf ${YELLOW} "[INFOS]"
    printf ${YELLOW} "[INFOS] ===================================================="
    printf ${YELLOW} "[INFOS]  DATE : $(date +"%Y-%m-%d_%H:%M:%S")"
    printf ${YELLOW} "[INFOS]  $1"
    printf ${YELLOW} "[INFOS] ===================================================="
    printf ${NOCOLOR}
}

function msg_error() {
    printf ${RED} "[ WARN ]"
    printf ${RED} "[ WARN ] ===================================================="
    printf ${RED} "[ WARN ]  DATE : $(date +"%Y-%m-%d_%H:%M:%S")"
    printf ${RED} "[ WARN ]  $1"
    printf ${RED} "[ WARN ] ===================================================="
    printf ${NOCOLOR}
}

function msg_output() {
    printf ${GREEN} "[ OUT ]"
    printf ${GREEN} "[ OUT ] ===================================================="
    printf ${GREEN} "[ OUT ]  DATE : $(date +"%Y-%m-%d_%H:%M:%S")"
    printf ${GREEN} "[ OUT ]  $1"
    printf ${GREEN} "[ OUT ] ===================================================="
    printf ${NOCOLOR}
}

lab_ready() {
    printf ${GREEN} "[INFOS]"
    printf ${GREEN} "[INFOS] ===================================================="
    printf ${GREEN} "[INFOS]  DATE : $(date +"%Y-%m-%d_%H:%M:%S")"
    printf ${GREEN} "[INFOS]  "
    printf ${GREEN} "[INFOS]  Lab is ready to be used"
    printf ${GREEN} "[INFOS]  Tools Available:"
    printf ${GREEN} "[INFOS]  "
    printf ${GREEN} "[INFOS]  - k9s"
    printf ${GREEN} "[INFOS]  - kubectl"
    printf ${GREEN} "[INFOS]  - helm"
    printf ${GREEN} "[INFOS]  - kubens"
    printf ${GREEN} "[INFOS]  - kind"
    printf ${GREEN} "[INFOS]  - yq"
    printf ${GREEN} "[INFOS]  - jq"
    printf ${GREEN} "[INFOS]  " 
    printf ${GREEN} "[INFOS] ===================================================="
    printf ${GREEN} "[INFOS]  "
    printf ${NOCOLOR}
    kubectl get all --all-namespaces
}