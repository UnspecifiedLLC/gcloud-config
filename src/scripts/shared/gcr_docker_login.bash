#!/bin/bash

default_account=$(cat /root/.config/gcloud/configurations/config_default | grep "^account =" | sed 's/account = //g')
keyfile="/root/.config/gcloud/legacy_credentials/${default_account}/adc.json"
docker login -u _json_key -p "$(cat ${keyfile})" https://gcr.io
