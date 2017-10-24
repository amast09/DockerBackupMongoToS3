#!/bin/bash

# Define the backup file and archive names to use
BACKUP_FILENAME="backup-"$(TZ=America/New_York date +"%Y-%b-%d__%H:%M:%S")
BACKUP_ARCHIVE_FILENAME=${BACKUP_FILENAME}.tar.gz
# Define the S3 path
S3_PATH=${S3_PATH:?"S3_PATH env variable is required"}

# Dump the data from mongoDB into our backup file
mongodump -h ${MONGO_HOST} -o ${BACKUP_FILENAME}

# Compress our result
tar -zcvf ${BACKUP_ARCHIVE_FILENAME} ${BACKUP_FILENAME}

# Transfer the archive to Amazon S3
s3cmd -c /root/.s3cfg put ${BACKUP_ARCHIVE_FILENAME} ${S3_PATH}

# Clean up after ourselves, don't want this container to have a bunch of old backups in it
rm -rf ${BACKUP_FILENAME}
rm -rf ${BACKUP_ARCHIVE_FILENAME}
