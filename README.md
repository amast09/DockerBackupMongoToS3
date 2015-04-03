Simple Docker Container to Backup MongoDB Docker Container to Amazon S3
===================

Docker container that periodically backs up a Dockerized MongoDB Database to Amazon S3 using [s3cmd sync] (http://s3tools.org/s3cmd-sync)

### Usage:

	docker run -d [OPTIONS] <docker_image>

### Parameters:

`-e ACCESS_KEY=<AWS_KEY>`
<p>Your AWS key.</p>

`-e SECRET_KEY=<AWS_SECRET>`
<p>Your AWS secret.</p>

`-e S3_PATH=s3://<BUCKET_NAME>/<PATH>/`
<p>S3 Bucket name and path. Should end with trailing slash.</p>

`-e MONGO_HOST=<MONGO_DATABASE_CONTAINER_NAME>`
<p>The linked container name of the Dockerized MongoDB you want backed up.</p>

### Optional parameters:

`-e INTERVAL=<BACKUP_FREQUENCY>`
<p>How often you want your MongoDB container backed up expressed using Unix sleep like syntax [s for seconds, m for minutes, h for hours, d for days]</p>
<p>If not specified, it will do an immidiate backup of the supplied MongoDB container</p>

### Example:

docker run -t \
    --name mongobackup \
    --link phantomdb:phantomdb \
    -e ACCESS_KEY=afvkjad34ad43kf4j5b6v7ald \
    -e SECRET_KEY=adfklv34na343dfkv \
    -e S3_PATH=s3://backup-bucket/db-folder/ \
    -e MONGO_HOST=mongocontainer \
    -e INTERVAL=90d \
    amast09/mongo_backup
