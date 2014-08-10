# Using dockerimages ubuntu-vm image it has pre installed ssh agent and a init on /sbin/my_init
# For support watch at phpusin baseimage-docker ubuntu-vm is based on that with some additions
# For internal use 
FROM dockerimages/ubuntu-vm:latest
RUN apt-get -y update && apt-get -y install \
apache2 libapache2-mod-passenger mysql-server mysql-client 
RUN service mysql start && \
apt-get install -y redmine redmine-mysql 
# redmine(instances)/default

# etc/apache2/mods-available/passenger.conf which needs the text PassengerDefaultUser www-data added as seen here:
RUN cat << EOF > /apache2/mods-available/passenger.conf
<IfModule mod_passenger.c>
  PassengerDefaultUser www-data
  PassengerRoot /usr
  PassengerRuby /usr/bin/ruby
</IfModule>
EOF

RUN sudo ln -s /usr/share/redmine/public /var/www/redmine
#RUN cat << EOF > /etc/apache2
#<Directory /var/www/redmine>
#    RailsBaseURI /redmine
#    PassengerResolveSymlinksInDocumentRoot on
#</Directory>
CMD /etc/init.d/apache2 start && \
    service mysql start &&\
    /sbin/my_init
# latest dev version
#RUN hg clone https://bitbucket.org/redmine/redmine-trunk redmine
