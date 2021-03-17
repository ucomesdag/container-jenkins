FROM jenkins/jenkins:lts

ARG BUILD_DATE

LABEL summary="Jenkins Container Image that can run container nodes."
LABEL maintainer="Uco Mesdag <uco@mesd.ag>"
LABEL build-date=${BUILD_DATE}

WORKDIR /var/jenkins_home

USER root

# Fix for proxy causing `Hash Sum mismatch` errors
RUN touch /etc/apt/apt.conf.d/99fixbadproxy \
      && echo "Acquire::http::Pipeline-Depth 0;" >> /etc/apt/apt.conf.d/99fixbadproxy \
      && echo "Acquire::http::No-Cache true;" >> /etc/apt/apt.conf.d/99fixbadproxy \
      && echo "Acquire::BrokenProxy true;" >> /etc/apt/apt.conf.d/99fixbadproxy

RUN apt-get update && apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      gnupg \
      lsb-release \
      podman

# USER jenkins

RUN jenkins-plugin-cli --plugins \
      blueocean \
      timestamper \
      workflow-aggregator \
      pipeline-stage-view \
      ws-cleanup \
      github \
      build-discarder
