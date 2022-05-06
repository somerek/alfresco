#!/bin/sh
mydatetime=`date +%Y-%m-%d-%H-%M`

mkdir backup
# Backup Alfresco files
#docker exec -it alfresco sh -c "tar -czvf /backup/alf_data_$mydatetime.tar.gz /opt/alf_data"
#rsnapshot now!!!

# Backup DB
docker exec alfresco-postgres pg_dump -Fp -C -h localhost -U alfresco alfresco | gzip -9 > /home/roman/alfresco/backup/dump_$mydatetime.sql.gz
