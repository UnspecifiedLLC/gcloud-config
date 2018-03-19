(Making a public repository)[https://cloud.google.com/container-registry/docs/access-control#serving_images_publicly]

(Using bind mounts)[https://docs.docker.com/v17.09/engine/admin/volumes/bind-mounts/]

(creating service accounts)[https://cloud.google.com/docs/authentication/getting-started]

(travis build lifecycle)[https://docs.travis-ci.com/user/customizing-the-build/#The-Build-Lifecycle]

(Google Cloud Platform cloud-builders)[https://github.com/GoogleCloudPlatform/cloud-builders]

(http://gcr.io/un-cloud-builders/fission:latest) fission builder

docker run -it --rm --mount source=<volume>,target=/root/.config/gcloud gcr.io/un-cloud-builders/gcloud-config:latest


docker run -it --rm -e GCLOUD_SERVICE_KEY=`cat ~/Desktop/GCR_SERVICE_KEY.txt` --mount source=gcloud,target=/root/.config/gcloud gcr.io/un-cloud-builders/gcloud-config:latest

docker run -it --rm --mount source=gcloud,target=/root/.config/gcloud gcr.io/un-cloud-builders/gcloud-config:latest

  # master:
  #   unspecified/cloud-builders-gcloud-config:latest
  #   gcr.io/un-cloud-builders/build-config:latest
  # tag:
  #   unspecified/cloud-builders-gcloud-config:<tag>
  #   gcr.io/un-cloud-builders/build-config:<tag>
  # pull request:
  #   unspecified/cloud-builders-gcloud-config:<branch>
  #   gcr.io/un-cloud-builders/build-config:<branch>
  # other:

after_script:
  docker volume rm config-gcloud