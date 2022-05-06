FROM cmccambridge/ocrmypdf-auto
RUN apt update && apt install -y tesseract-ocr-rus curl ftp iputils-ping ssh mc sudo mutt
RUN groupadd ftp && usermod -a -G ftp docker
RUN echo "docker ALL=(ALL) NOPASSWD:ALL" >>  /etc/sudoers
WORKDIR /app
COPY ocrmypdf-auto.py .
COPY scan.call .
COPY ftp_upload.sh .
COPY docker-entrypoint.sh .
RUN chmod +x ./ftp_upload.sh ./docker-entrypoint.sh
