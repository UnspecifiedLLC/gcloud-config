#!/bin/bash
# Location of key file after config:
# /root/.config/gcloud/legacy_credentials/un-cloud-builders-sa@un-cloud-builders.iam.gserviceaccount.com

# File listing the default gcloud account:
# ~/.config/gcloud# cat configurations/config_default

# location of key file using 'account' from config_default:
# /root/.config/gcloud/legacy_credentials/${account}/adc.json

#default account
whoami
default_account=$(cat /root/.config/gcloud/configurations/config_default | grep "^account =" | sed 's/account = //g')
echo ${default_account}
keyfile="/root/.config/gcloud/legacy_credentials/${default_account}/adc.json"
echo ${keyfile}
docker login -u _json_key -p "$(cat ${keyfile})" https://gcr.io
