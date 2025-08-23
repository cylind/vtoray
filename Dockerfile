FROM alpine:latest

RUN wget https://github.com/cylind/enginx/releases/latest/download/vserver -O /usr/local/bin/vserver && \
    chmod +x /usr/local/bin/vserver

COPY config.json /etc/vserver/config.json

# 暴露端口 (PaaS 平台会自动映射)
EXPOSE 8080

CMD ["/usr/local/bin/vserver", "run", "-config", "/etc/vserver/config.json"]
