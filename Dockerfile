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

# copy custom config
RUN git clone https://github.com/ciudilo/kp_squid_conf.git
RUN cp kp_squid_conf/squid.conf /etc/squid/squid.conf
RUN echo "http_port 3129 intercept" >> /etc/squid/squid.conf

# start squid
CMD [ "/usr/sbin/squid", "-N" ]

