#!/bin/sh
cat << EOF > /app/config.json
{
  "log": {
    "loglevel": "none",
    "access": "/dev/null",
    "error": "/dev/null"
  },
  "inbounds": [
    {
      "port": ${PORT},
      "protocol": ${PROTOCOL},
      "settings": {
        "clients": [
          {
            "id": "${UUID}"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "${WS_PATH}"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF
exec /app/vserver run -config /app/config.json >/dev/null 2>&1