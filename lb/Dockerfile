FROM centos:centos7

MAINTAINER dariusz.stynski@gmail.com

RUN yum -y install epel-release 
RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN yum -y install puppet-server
RUN yum -y install hostname nfs-utils nginx tar 
ADD puppet /etc/puppet
RUN mkdir /etc/puppet/files
RUN rm /etc/nginx/nginx.conf
ADD manifest /etc/puppet/manifests
ADD nginx-watch.sh /bin/nginx-watch.sh
RUN chmod a+x /bin/nginx-watch.sh
ADD nginx.conf /etc/nginx/nginx.conf
ADD puppet-files /etc/puppet/files
RUN /usr/bin/puppet master --no-daemon
ADD shared /shared
RUN chmod -R 777 /shared
RUN echo "/shared *(rw,sync,no_subtree_check,fsid=0,no_root_squash)" > /etc/exports
RUN yum -y install supervisor
ADD supervisord.conf /etc/supervisord.conf
ADD startnfs.sh /bin/startnfs.sh
RUN chmod a+x /bin/startnfs.sh
EXPOSE 80 111 2049 8140 20049 
CMD supervisord -n

