FROM alpine:3.14.3

COPY glibc/ .
ADD apache-tomcat-8.5.78.tar.gz /usr/local

RUN \
    #install glibc6
    mv sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub; \
    apk add *.apk; \
    rm -rf *.apk; \
    #install jdk and useful utils
    echo "http://mirrors.aliyun.com/alpine/latest-stable/main/" > /etc/apk/repositories; \
    echo "http://mirrors.aliyun.com/alpine/latest-stable/community/" >> /etc/apk/repositories; \
    apk upgrade; \
    apk add --no-cache ca-certificates unzip curl bash bash-completion wget vim net-tools tzdata openjdk8; \
    rm -rf /tmp/* /var/cache/apk/*; \
    #make soft link to /usr/local/tomcat
    ln -s /usr/local/apache-tomcat-8.5.78 /usr/local/tomcat; \
    #delete unused folders
    rm -rf /usr/local/tomcat/webapps/*
   
ENV CATALINA_HOME=/usr/local/tomcat \
    LANG=C.UTF-8 \
    TZ=Asia/Shanghai

ENV PATH=$CATALINA_HOME/bin:$PATH

WORKDIR /usr/local/tomcat

EXPOSE 8080

CMD ["catalina.sh", "run"]
