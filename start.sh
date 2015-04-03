#!/bin/bash

ACCESS_KEY=${ACCESS_KEY:?"ACCESS_KEY env variable is required"}
SECRET_KEY=${SECRET_KEY:?"SECRET_KEY env variable is required"}

echo "access_key=$ACCESS_KEY" >> /root/.s3cfg
echo "secret_key=$SECRET_KEY" >> /root/.s3cfg

if [[ ${INTERVAL} == "" ]]; then
    sh ./backup-mongo.sh
else
    while true; do sh ./backup-mongo.sh; sleep ${INTERVAL}; done
fi