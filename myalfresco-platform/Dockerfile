FROM jeci/alfresco-platform:5.2.g
ENV FILE_PROPERTIES=/usr/local/tomcat/webapps/alfresco/WEB-INF/classes/alfresco-global.properties
RUN sed -i "s/ftp.enabled=false/ftp.enabled=true/g" ${FILE_PROPERTIES}
RUN echo ftp.port         = 2221 >> ${FILE_PROPERTIES}
RUN echo ftp.dataPortFrom = 2300 >> ${FILE_PROPERTIES}
RUN echo ftp.dataPortTo   = 2400 >> ${FILE_PROPERTIES}
#RUN echo ftp.externalAddress  = 192.168.3.6 >> ${FILE_PROPERTIES}
RUN echo                         >> ${FILE_PROPERTIES}
