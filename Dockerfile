# Using dockerimages ubuntu-vm image it has pre installed ssh agent and a init on /sbin/my_init
# For support watch at phpusin baseimage-docker ubuntu-vm is based on that with some additions
# For internal use 
FROM dockerimages/ubuntu-vm:latest
RUN apt-get -y update && apt-get -y install mercurial
# latest dev version
RUN hg clone https://bitbucket.org/redmine/redmine-trunk redmine
