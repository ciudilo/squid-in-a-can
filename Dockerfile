FROM tianon/centos:latest

# add epel repo
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# update
RUN yum -y update

# install base packages
RUN yum -y install git wget zsh

# fix paths
RUN echo 'Defaults  secure_path=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin' >> /etc/sudoers.d

# install squid
RUN yum -y install squid httpd-tools
RUN touch /etc/squid/squid_passwd
RUN chmod o+r /etc/squid/squid_passwd

# copy custom config
COPY squid.conf /etc/squid/squid.conf

# start squid
CMD [ "/usr/sbin/squid", "-N" ]

