FROM centos:centos7
MAINTAINER dariusz.stynski@gmail.com
RUN yum -y install epel-release hostname 
RUN ["/usr/bin/rpm", "--import", "https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs"]
RUN ["/usr/bin/rpm", "-ivh", "https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm"]
RUN ["/usr/bin/yum", "-y", "install", "puppet"]
RUN mkdir /shared
EXPOSE 80 111 2049 8140 
RUN yum -y install supervisor
COPY supervisord.conf /etc/supervisord.conf
COPY network.sh /bin/network.sh
COPY hosts /root/hosts
RUN chmod a+x /bin/network.sh
CMD supervisord -n

