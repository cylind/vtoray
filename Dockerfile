FROM alpine:latest

WORKDIR /app/

COPY config.json .

RUN wget https://github.com/cylind/enginx/releases/latest/download/vserver && \
    chmod +x ./vserver

# 暴露端口 (PaaS 平台会自动映射)
EXPOSE 8080

ENTRYPOINT ["/app/vserver"]

CMD ["run", "-config", "/app/config.json"]
