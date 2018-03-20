

Create a volume to be shared between gcloud-derived containers:
  - docker volume create config-gcloud

Run the gcloud-config container to activate a Google Cloud service account
  - docker run -it --rm
    --mount source=config-gcloud,target=/root/.config/gcloud
    -e GCLOUD_SERVICE_KEY=${GCLOUD_SERVICE_KEY=}
    gcr.io/un-cloud-builders/gcloud-config:${COMMIT_TAG}

Run another cloudbuilder container, mounting the volume with the configured service account
  - docker run -it --rm
    --mount source=config-gcloud,target=/root/.config/gcloud
    gcr.io/cloud-builders/docker images