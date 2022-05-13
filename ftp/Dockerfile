FROM fauria/vsftpd
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum install -y jq mc
COPY entrypoint.sh /root/
CMD [ "sh", "-c", "/root/entrypoint.sh && /usr/sbin/run-vsftpd.sh"]
