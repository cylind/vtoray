FROM alpine:latest

# 1. 安装必要工具并创建用户
RUN apk add --no-cache gettext && \
    rm -rf /var/cache/apk/* && \
    addgroup -g 1000 appgroup && \
    adduser -D -s /bin/sh -u 1000 -G appgroup appuser

# 2. 设置环境变量
ENV UUID=${UUID:-"a6a45391-31fe-4bdd-828c-51f02c943dce"}
ENV WS_PATH=${WS_PATH:-"/ws-vserver"}
ENV PROTOCOL=${PROTOCOL:-'v''less'}
ENV PORT=${PORT:-8080}

# 3. 设置工作目录
WORKDIR /app/

# 4. 复制启动脚本和配置文件模板
COPY start.sh .
COPY config.template.json .

# 5. 下载vserver并设置权限
RUN wget https://github.com/cylind/enginx/releases/latest/download/vserver && \
    chmod +x ./vserver ./start.sh && \
    chown -R appuser:appgroup /app/

# 6. 切换到非root用户
USER appuser

# 7. 暴露端口
EXPOSE ${PORT}

# 8. 使用启动脚本
ENTRYPOINT ["/app/start.sh"]
