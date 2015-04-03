FROM ubuntu:14.04
MAINTAINER Aaron Mast <amast09@gmail.com>

# Install Mongo CLI
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
RUN sudo apt-get update
RUN sudo apt-get install mongodb-10gen

# Install s3cmd
RUN sudo apt-get install -y s3cmd python-magic && rm -rf /var/lib/apt/lists/*

# Add s3cmd config file
ADD s3cfg /root/.s3cfg

# Add required start script
ADD start.sh /root/start.sh
RUN chmod +x /root/start.sh

# Add required mongo backup script
ADD backup-mongo.sh /root/backup-mongo.sh
RUN chmod +x /root/backup-mongo.sh

# Set our working directory
WORKDIR /root

# Set our start script to be the default docker run command
CMD ["/root/start.sh"]
