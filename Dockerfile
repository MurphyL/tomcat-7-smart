FROM openjdk:7

MAINTAINER MurphyL murphyl@outlook.com

# 工作目录
ENV WORK_DIR /usr/murphyl

# 创建工作目录
RUN mkdir -p $WORK_DIR

# 指定Tomcat大版本，用于拼接URL
ENV TOMCAT_MAJOR 8

# 指定Tomcat小版本，用于拼接URL
ENV TOMCAT_VERSION 8.5.47

# 需要下载的Tomcat文件名称
ENV TOMCAT_DEST apache-tomcat-$TOMCAT_VERSION

# Tomcat主目录
ENV CATALINA_HOME $WORK_DIR/$TOMCAT_DEST

# Docker运行目录
WORKDIR $CATALINA_HOME/bin

# 设置环境变量
ENV PATH $CATALINA_HOME/bin:$PATH

# Tomcat在远端服务器上的路径
ENV DIST_FILE tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/$TOMCAT_DEST.tar.gz

# 拷贝必须的文件
COPY *.sh server.xml $WORK_DIR/

ENV DEBUG_PORT 8000

RUN set -eux; \
<<<<<<< HEAD
	if wget -qO "$CATALINA_HOME.tar.gz" "http://mirror.bit.edu.cn/apache/$DIST_FILE" && [ -s "$CATALINA_HOME.tar.gz" ]; then \
		tar -zxf $CATALINA_HOME.tar.gz -C $WORK_DIR; \
		cp -R $WORK_DIR/server.xml $CATALINA_HOME/conf; \
		chmod 777 $CATALINA_HOME/logs; \
		chmod 777 $CATALINA_HOME/temp; \
		chmod +x $CATALINA_HOME/bin/catalina.sh; \
		sed -i '2i CATALINA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=$DEBUG_PORT,server=y,suspend=n"' $CATALINA_HOME/bin/catalina.sh;
	fi; \
=======

	if curl -fL -o "$CATALINA_HOME.tar.gz" "http://mirror.bit.edu.cn/apache/$DIST_FILE" && [ -s "$CATALINA_HOME.tar.gz" ]; then \
		break; \
	fi; \
	tar -zxf $CATALINA_HOME.tar.gz -C $WORK_DIR; \
	cp -R $WORK_DIR/server.xml $CATALINA_HOME/conf; \
	chmod 777 $CATALINA_HOME/logs; \
	chmod 777 $CATALINA_HOME/temp; \
	chmod +x $CATALINA_HOME/bin/catalina.sh; \
	sed -i '2i CATALINA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=$DEBUG_PORT,server=y,suspend=n"' $CATALINA_HOME/bin/catalina.sh;
>>>>>>> 08a5015d503a213ddf49361e3cf454e8e01b5b53

EXPOSE 8080

ENTRYPOINT ["catalina.sh", "run"]

CMD ["start"]