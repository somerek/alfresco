#!/bin/bash

# For filenames with space:
in_file=`echo $1 | sed 's/ /[[:space:]]/g'`
out_file=`echo $2 | sed 's/ /[[:space:]]/g'`
username=$3
#password=$4
bitrixId=$5
phoneIP=$6
phoneNum=$7
filename=`echo $1 | sed 's|.*/\([^/]*\)$|\1|'`
filetxt=`echo $1 | sed -r 's/\.[[:alnum:]]+$/.txt/'`

word2=`echo "$1" |  cut -d '/' -f 3`
word3=`echo "$1" |  cut -d '/' -f 4`

if [ "$word2" == "berezhnaya_ov" ] && [ "$word3" == "FAX" ]; then
# Make folder FAX
ftp -n alfresco 2221 <<END_SCRIPT
quote USER $alfresco_admin
quote PASS $alfresco_password
cd Alfresco
cd "User Homes"
cd $username
mkdir FAX
quit
END_SCRIPT
# Upload output file to ftp alfresco
curl --user $alfresco_admin:$alfresco_password --upload-file $out_file "ftp://alfresco:2221/Alfresco/User Homes/$username/FAX/"
cat "$filetxt" | mutt -s "FAX" -e 'my_hdr From: FAX server <postmaster@edc-electronics.ru>' -a "$2" -- fax@mail.edc-electronics.ru
# Clean
sudo rm "$1"
sudo rm "$filetxt"
rm "$2"
rm sent
else

# NOT FAX
# Make folder scan
ftp -n alfresco 2221 <<END_SCRIPT
quote USER $alfresco_admin
quote PASS $alfresco_password
cd Alfresco
cd "User Homes"
cd $username
mkdir scan
quit
END_SCRIPT

# Upload output file to ftp alfresco
curl --user $alfresco_admin:$alfresco_password --upload-file $out_file "ftp://alfresco:2221/Alfresco/User Homes/$username/scan/"

chown docker:docker /ftp_acc/root\@asterisk
chmod 600 /ftp_acc/root\@asterisk

# Notify to asterisk
ping -q -c1 $phoneIP > /dev/null

if [ $? -eq 0 ]
then
cp /app/scan.call /tmp/scan$username.call
echo "Channel: Local/*80$phoneNum@from-internal" >> /tmp/scan$username.call
scp -i /ftp_acc/root@asterisk -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null /tmp/scan$username.call root@192.168.3.4:/var/spool/asterisk/outgoing
rm /tmp/scan$username.call
fi

# Notify to bitrix
curl -s -k $bitrix_url -F MESSAGE="Scaned: $filename" -F DIALOG_ID=$bitrixId

# Clean
sudo rm "$1"
rm "$2"
rm sent
fi

exit 0 # OK!
