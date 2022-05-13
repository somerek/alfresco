#!/bin/bash

username=$3
#password=$4
bitrixId=$5
phoneIP=$6
phoneNum=$7
filename=`echo $1 | sed 's|.*/\([^/]*\)$|\1|'`
filetxt=`echo $1 | sed -r 's/\.[[:alnum:]]+$/.txt/'`
filepath=`echo "${2%/*}" | cut -d '/' -f 4-`

word2=`echo "$1" |  cut -d '/' -f 3`
word3=`echo "$1" |  cut -d '/' -f 4`

if [ "$word2" == "berezhnaya_ov" ] && [ "$word3" == "FAX" ]; then
ncftpput -u $alfresco_admin -p $alfresco_password -P 2221 -m alfresco "/Alfresco/User Homes/$username/FAX" "$2"
cat "$filetxt" | mutt -s "FAX" -e 'my_hdr From: FAX server <postmaster@edc-electronics.ru>' -a "$2" -- fax@mail.edc-electronics.ru
# Clean
sudo rm "$1"
sudo rm "$filetxt"
rm "$2"
rm sent
else

# NOT FAX
# Upload output file to ftp alfresco
ncftpput -u $alfresco_admin -p $alfresco_password -P 2221 -m alfresco "/Alfresco/User Homes/$username/scan/$filepath" "$2"

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
fi

exit 0 # OK!
