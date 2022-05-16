FROM cmccambridge/ocrmypdf-auto
RUN apt-get update && apt-get install --no-install-recommends -y tesseract-ocr-rus curl iputils-ping ssh sudo mutt ncftp libsasl2-modules && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /app
COPY ocrmypdf-auto.py .
COPY scan.call .
COPY ftp_upload.sh .
RUN chmod +x ./ftp_upload.sh
ENTRYPOINT [ "sh", "-c", "echo \"set smtp_url = \"$smtp_url\"\" > .muttrc && /app/docker-entrypoint.sh"]
