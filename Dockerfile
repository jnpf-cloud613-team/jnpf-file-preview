# 基础镜像
FROM hub.yinmaisoft.com/jnpf-devops-agent/base-file-preview-jre:21
# FROM hub.yinmaisoft.com/jnpf-devops-agent/base-file-preview-jre:17
# FROM hub.yinmaisoft.com/jnpf-devops-agent/base-file-preview-jre:11
# FROM hub.yinmaisoft.com/jnpf-devops-agent/base-file-preview-jre:8
LABEL maintainer=jnpf-team

# 将构建产物拷贝到运行时目录中
ADD server/target/kkFileView-*.tar.gz /opt/
# 指定容器内运行端口
EXPOSE 30090
ENV KKFILEVIEW_BIN_FOLDER /opt/kkFileView-4.4.0-RELEASE/bin
# 指定容器启动时要运行的命令
ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-Dspring.config.location=/opt/kkFileView-4.4.0-RELEASE/config/application.properties","-jar","/opt/kkFileView-4.4.0-RELEASE/bin/kkFileView-4.4.0-RELEASE.jar"]