#!/bin/sh
# 使用envsubst处理模板文件
envsubst < /app/config.template.json > /app/config.json

exec /app/vserver run -config /app/config.json >/dev/null 2>&1