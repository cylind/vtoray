FROM alpine:latest

# 1. 创建用户（系统已内置所需工具）
RUN addgroup -g 1000 appgroup && \
    adduser -D -s /bin/sh -u 1000 -G appgroup appuser

# 2. 设置环境变量
ENV UUID=${UUID:-"a6a45391-31fe-4bdd-828c-51f02c943dce"}
ENV WS_PATH=${WS_PATH:-"/ws-vserver"}
ENV PORT=${PORT:-8080}
ENV PROTOCOL='v''less'

# 3. 设置工作目录
WORKDIR /app/

# 4. 复制配置文件模板
COPY config.template.json .

# 5. 下载vserver并设置权限（合并相关操作）
RUN wget https://github.com/cylind/enginx/releases/latest/download/vserver && \
    chmod +x ./vserver && \
    chown -R appuser:appgroup /app/

# 6. 切换到非root用户
USER appuser

# 7. 暴露端口
EXPOSE ${PORT}

# 8. 设置入口点和运行时配置生成（日志重定向）
ENTRYPOINT ["/bin/sh", "-c", "envsubst < /app/config.template.json > /app/config.json && /app/vserver run -config /app/config.json > /dev/null 2>&1"]
