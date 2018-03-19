#!/bin/bash
# base64 decode the given GCLOUD_SERVICE_KEY into a tmp json file
# activate the account
# if a project is given, activate it
# if a zone is given, set it
# if a cluster is given, activate it (? - we derive from gcloud, not kubectl; may not have access to this)

# If there is no current context, get one.
if [ ! -z "$GCLOUD_SERVICE_KEY" ]
then
    rootdir=/root/.config/gcloud-config
    mkdir -p $rootdir
    tmpdir=$(mktemp -d "$rootdir/servicekey.XXXXXXXX")
    trap "echo deleting temp dir ${tmpdir}; rm -rf $tmpdir" EXIT
    echo "created tmp dir: ${tmpdir}"
    echo ${GCLOUD_SERVICE_KEY} | base64 --decode -i > ${tmpdir}/gcloud-service-key.json
    gcloud auth activate-service-account --key-file ${tmpdir}/gcloud-service-key.json
else
    echo "\$GCLOUD_SERVICE_KEY environment variable is not set"
fi

active_account=$(gcloud auth list --filter=status:ACTIVE --format="value(account)" 2> /dev/null)

function funct_usage() {
    cat <<EOF
No gcloud account is active.

To make use of this container:
1) mount a shared volume for a gcloud configuration:
    All containers that use the google cloud SDK should mount this volume to receive runtime gcloud configuration (i.e., the active account).
    The 'target' for this volume needs to be '/root/.config/gcloud'.
2) provide gcloud service credentials:
    This container will activate the service account specified provided. Context information for the activated account will be kept in the shared volume.
    If no credentials are provided, then this container will only act as a guard to ensure that an activated account is configured in the shared volume.

A shared volume can be provided by adding this switch when starting the container:
    --mount source=<volume>,target=/root/.config/gcloud

Service credentials are provided by base64 encoding a a json service key, and passing it as an environment variable:
    GCLOUD_SERVICE_KEY=<base64 encoded Google service key>
EOF
    exit 1
}

[[ -z "$active_account" ]] && funct_usage
echo "Active account: $active_account"

