FROM registry.access.redhat.com/rhel7/rhel:latest

MAINTAINER Samuel Terburg <sterburg@redhat.com>

COPY watch.sh   /watch.sh
COPY oc         /usr/local/bin/oc

CMD /watch.sh
