FROM cmccambridge/ocrmypdf-auto
RUN apt update && apt install -y tesseract-ocr-rus curl ftp iputils-ping ssh mc sudo mutt ncftp
RUN groupadd ftp && usermod -a -G ftp docker
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >>  /etc/sudoers
WORKDIR /app
COPY ocrmypdf-auto.py .
COPY scan.call .
COPY ftp_upload.sh .
RUN chmod +x ./ftp_upload.sh
ENTRYPOINT [ "sh", "-c", "echo \"set smtp_url = \"$smtp_url\"\" > .muttrc && /app/docker-entrypoint.sh"]
