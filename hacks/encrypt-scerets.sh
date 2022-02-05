#!/usr/bin/env bash

set -o errexit
set -o pipefail

# shellcheck disable=SC2155
export PROJECT_DIR=$(git rev-parse --show-toplevel)

# shellcheck disable=SC2155
export SOPS_AGE_KEY_FILE=~/.config/sops/age/keys.txt

# shellcheck disable=SC1091
source "${PROJECT_DIR}/.config.env"

main() {
    local verify=

    parse_command_line "$@"

    verify_binaries

    if [[ "${verify}" == 1 ]]; then
#        verify_ansible_hosts
#        verify_metallb
#        verify_kubevip
#        verify_age
#        verify_git_repository
#        verify_cloudflare
#        success
    else
        # sops configuration file
        sops --encrypt --in-place "${PROJECT_DIR}/cluster/base/cluster-secrets.sops.yaml"
#        sops --encrypt --in-place "${PROJECT_DIR}/cluster/core/cert-manager/secret.sops.yaml"
        # terraform
#        envsubst < "${PROJECT_DIR}/tmpl/terraform/secret.sops.yaml" \
#            > "${PROJECT_DIR}/provision/terraform/cloudflare/secret.sops.yaml"
#        sops --encrypt --in-place "${PROJECT_DIR}/provision/terraform/cloudflare/secret.sops.yaml"
        # ansible
#        envsubst < "${PROJECT_DIR}/tmpl/ansible/kube-vip.yml" \
#            > "${PROJECT_DIR}/provision/ansible/inventory/group_vars/kubernetes/kube-vip.yml"
#        generate_ansible_hosts
#        generate_ansible_host_secrets
    fi
}