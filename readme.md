(Making a public repository)[https://cloud.google.com/container-registry/docs/access-control#serving_images_publicly]

(Using bind mounts)[https://docs.docker.com/v17.09/engine/admin/volumes/bind-mounts/]

(creating service accounts)[https://cloud.google.com/docs/authentication/getting-started]

(travis build lifecycle)[https://docs.travis-ci.com/user/customizing-the-build/#The-Build-Lifecycle]

(Google Cloud Platform cloud-builders)[https://github.com/GoogleCloudPlatform/cloud-builders]

(http://gcr.io/un-cloud-builders/fission:latest) fission builder

docker run -it --rm --mount source=<volume>,target=/root/.config/gcloud gcr.io/un-cloud-builders/gcloud-config:latest


docker run -it --rm -e GCLOUD_SERVICE_KEY=`cat ~/Desktop/GCR_SERVICE_KEY.txt` --mount source=gcloud,target=/root/.config/gcloud gcr.io/un-cloud-builders/gcloud-config:latest

docker run -it --rm --mount source=gcloud,target=/root/.config/gcloud gcr.io/un-cloud-builders/gcloud-config:latest

sudo: false
language: generic

cache:
  directories:
    - "$HOME/google-cloud-sdk/"

services:
  - docker

env:
  global:
    - BASENAME=GCLOUD-CONFIG
    - COMMIT_TAG=${TRAVIS_COMMIT::6}

before_install:

install:
  docker pull gcr.io/cloud-builders/docker
  docker volume create config-gcloud

script:
  docker build -t gcr.io/un-cloud-builders/gcloud-config:${COMMIT_TAG} .
  docker run -it --rm \
    --mount source=config-gcloud,target=/root/.config/gcloud \
    gcr.io/un-cloud-builders/gcloud-config:${COMMIT_TAG}
  # run tests
  docker images
    # - docker volume create tmp-vol
    # - there should be multiple GCR service keys, to test authentication:
    #   - read-only / minimal access to project
    #   - well formed key with no access to project
    #   - bogus key

  ls -al /var/run/docker.sock
  # if pass, push the image to:
  # master:
  docker run -it --rm \
    --mount source=gcloud,target=/root/.config/gcloud \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -gcr.io/cloud-builders/docker images
  #   unspecified/cloud-builders-gcloud-config:latest
  #   gcr.io/un-cloud-builders/build-config:latest
  # tag:
  #   unspecified/cloud-builders-gcloud-config:<tag>
  #   gcr.io/un-cloud-builders/build-config:<tag>
  # other:

after_script:
  docker volume rm config-gcloud