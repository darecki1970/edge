FROM centos:centos7

MAINTAINER dariusz.stynski@gmail.com

RUN yum -y install epel-release 
RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN yum -y install puppet-server
RUN yum -y install hostname nfs-utils nginx tar 
ADD puppet.conf /etc/puppet/puppet.conf
ADD autosign.conf /etc/puppet/autosign.conf
ADD fileserver.conf /etc/puppet/fileserver.conf
RUN mkdir /etc/puppet/files
RUN rm /etc/nginx/nginx.conf
ADD site.pp /etc/puppet/manifests/site.pp
ADD nodes.pp /etc/puppet/manifests/nodes.pp
ADD nginx.conf /etc/nginx/nginx.conf
ADD hosts /root/hosts
RUN /usr/bin/puppet master --no-daemon
RUN puppet module install puppetlabs/nginx
RUN puppet module install puppetlabs-mysql
ADD master.sh /etc/puppet/files/master.sh
ADD master.sql /etc/puppet/files/master.sql
ADD nginx.conf-srv1 /etc/puppet/files/nginx.conf-srv1
ADD master_my.cnf /etc/puppet/files/master_my.cnf
ADD shared /shared
RUN chmod -R 777 /shared
RUN echo "/shared *(rw,sync,no_subtree_check,fsid=0,no_root_squash)" > /etc/exports
ADD network.sh /bin/network.sh
RUN chmod a+x /bin/network.sh
RUN yum -y install supervisor
ADD supervisord.conf /etc/supervisord.conf
ADD startnfs.sh /bin/startnfs.sh
RUN chmod a+x /bin/startnfs.sh
EXPOSE 80 111 2049 8140 20049 
CMD supervisord -n

