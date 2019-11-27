#!/bin/bash

# Define the backup file and archive names to use
BACKUP_FILENAME="backup-"$(date +%m-%d-%Y_%H-%M%z)
BACKUP_ARCHIVE_FILENAME=${BACKUP_FILENAME}.tar.gz
MONGO_HOST=${1}
S3_PATH=${2}

# Dump the data from mongoDB into our backup file
mongodump -h ${MONGO_HOST} -o ${BACKUP_FILENAME}

# Compress our result
tar -zcvf ${BACKUP_ARCHIVE_FILENAME} ${BACKUP_FILENAME}

# Transfer the archive to Amazon S3
aws s3 cp ${BACKUP_ARCHIVE_FILENAME} ${S3_PATH}

# Clean up after ourselves, don't want this container to have a bunch of old backups in it
rm -rf ${BACKUP_FILENAME}
rm -rf ${BACKUP_ARCHIVE_FILENAME}
