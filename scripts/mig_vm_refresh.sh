#!/bin/sh

set -e

APP=$1
PROJECTID=$2
APPROVED=$3

if [[ "$APPROVED" == true ]]; then
gcloud config set project "${PROJECTID}"

 if [[ $PROJECTID == *"dev"* ]]; then
    ENV=d
 elif [[ $PROJECTID == *"prod"* ]]; then
    ENV=p
 fi

gcloud compute instance-groups managed resize gce-eu-west2-"${ENV}"-"${APP}"-mig --size=0 --region europe-west2

sleep 1m

gcloud compute instance-groups managed resize gce-eu-west2-"${ENV}"-"${APP}"-mig --size=1 --region europe-west2

elif [[ "$APPROVED" == false ]]; then
  echo "forgot to tick the box"
fi
