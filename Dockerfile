FROM registry.access.redhat.com/rhel7/rhel:latest

MAINTAINER Bouwen de Vries

COPY watch.sh   /watch.sh
COPY oc         /usr/local/bin/oc

CMD /watch.sh
