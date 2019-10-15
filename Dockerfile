FROM openjdk:7

ENV WORK_DIR /usr/smart

ENV TOMCAT_MAJOR 8

ENV TOMCAT_VERSION 8.5.47

ENV DIST_FILE "tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.zip"

ENV TOMCAT_DEST apache-tomcat-$TOMCAT_VERSION

ENV CATALINA_HOME $WORK_DIR/$TOMCAT_DEST

WORKDIR $CATALINA_HOME/bin

ENV PATH $CATALINA_HOME/bin:$PATH

COPY *.sh server.xml $WORK_DIR/

RUN set -eux; \
	# https://github.com/docker-library/tomcat/blob/8348a86101660e76224afcc57c4c9fae4dc76de8/9.0/jdk13/openjdk-oracle/Dockerfile
	for mirror in \
		'http://mirror.bit.edu.cn/apache/' \
		'https://mirrors.tuna.tsinghua.edu.cn/apache/' \
		'https://www.apache.org/dist/' \
		'https://archive.apache.org/dist/' \
	; do \
		if curl -fL -o "$WORK_DIR/$TOMCAT_DEST.zip" "$mirror$DIST_FILE" && [ -s "$WORK_DIR/$TOMCAT_DEST.zip" ]; then \
			break; \
		fi; \
	done; \
	
RUN	unzip $WORK_DIR/$TOMCAT_DEST.zip -d $WORK_DIR; \
	cp -R $WORK_DIR/server.xml $CATALINA_HOME/conf; \
	chmod 777 $CATALINA_HOME/logs; \
	chmod 777 $CATALINA_HOME/temp; \
	chmod 777 $CATALINA_HOME/bin/catalina.sh;

EXPOSE 8080

CMD ["catalina.sh", "run", "start"]