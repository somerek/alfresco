#!/bin/sh
docker exec alfresco-postgres pg_dump -Fp -C -h localhost -U alfresco alfresco | gzip -9 > /mnt/12TB/alfresco-data/dump_db.sql.gz
