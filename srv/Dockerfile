FROM centos:centos7
MAINTAINER dariusz.stynski@gmail.com
RUN yum -y install epel-release hostname 
RUN rpm --import https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
RUN yum -y install puppet
EXPOSE 80 111 2049 
RUN yum -y install supervisor
COPY supervisord.conf /etc/supervisord.conf
CMD supervisord -n
