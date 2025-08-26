FROM alpine:latest

# 1. 安装必要工具并创建用户
RUN apk add --no-cache gettext && \
    rm -rf /var/cache/apk/* && \
    addgroup -g 1000 appgroup && \
    adduser -D -s /bin/sh -u 1000 -G appgroup appuser

# 2. 设置环境变量
ENV UUID=${UUID:-"a6a45391-31fe-4bdd-828c-51f02c943dce"}
ENV WS_PATH=${WS_PATH:-"/ws-vserver"}
ENV PORT=${PORT:-8080}
ENV PROTOCOL='v''less'

# 3. 设置工作目录
WORKDIR /app/

# 4. 复制启动脚本
COPY start.sh .

# 5. 下载vserver并设置权限（合并相关操作）
RUN wget https://github.com/cylind/enginx/releases/latest/download/vserver && \
    chmod +x ./vserver ./start.sh && \
    chown -R appuser:appgroup /app/

# 6. 切换到非root用户
USER appuser

# 7. 暴露端口
EXPOSE ${PORT}

# 8. 使用启动脚本
ENTRYPOINT ["/app/start.sh"]
