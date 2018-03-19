from gcr.io/cloud-builders/gcloud:latest

COPY src/scripts /builder/gcloud-config/scripts

# RUN mkdir /root/.config/gcloud

# VOLUME /root/.config/gcloud

ENTRYPOINT ["/builder/gcloud-config/scripts/configure.bash"]