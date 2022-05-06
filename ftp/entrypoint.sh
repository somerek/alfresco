#!/bin/sh
file_users=/etc/vsftpd/virtual_users.txt

# Clean
:>$file_users

jq -c '.personal | .[]' /ftp_acc/users.json | while read i; do
    username=`echo $i | jq '.username'| sed 's/^"\(.*\)"$/\1/'`
    mkdir /home/vsftpd/$username
    chmod 777 /home/vsftpd/$username
    echo $username >> $file_users
    echo $i | jq '.password'| sed 's/^"\(.*\)"$/\1/' >> $file_users
done
/usr/bin/db_load -T -t hash -f $file_users /etc/vsftpd/virtual_users.db
