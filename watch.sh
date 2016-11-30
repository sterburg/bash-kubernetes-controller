#!/bin/sh -x

export IFS=" "

oc get projects --watch --template=$'{{.metadata.name}} {{.status.phase}} {{.metadata.annotations}}\n' \
  |grep  --line-buffered "role=workload"        \
  |sed   -ur 's/map.*selector:([^ ]*) .*$/\1/g' \
  |while read PROJECT PHASE SELECTOR
do
  echo "$PROJECT entered phase $PHASE on node $SELECTOR"
  case $PHASE in
  "Active")
    oc adm new-project ${PROJECT}-ops --node-selector="${SELECTOR/zone=app,role=workload/zone=dmz,role=proxy}"
    oc project ${PROJECT}-ops
    oc adm pod-network join-projects --to=${PROJECT} ${PROJECT}-ops
    oc new-app --template=ops/squid
    ;;
  "Terminating")
    oc delete project ${PROJECT}-ops
    ;;
  esac
done

