from gcr.io/cloud-builders/gcloud

COPY src/scripts /builder/gcloud-config/scripts

ENTRYPOINT ["/builder/gcloud-config/scripts/activate.bash"]