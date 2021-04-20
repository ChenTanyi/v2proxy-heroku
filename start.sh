#!/bin/sh
set -e

mkdir /v2ray
wget https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip -P /v2ray
unzip /v2ray/v2ray-linux-64.zip -d /v2ray
chmod +x /v2ray/v2ray && mv /v2ray/v2ray /usr/bin
chmod +x /v2ray/v2ctl && mv /v2ray/v2ctl /usr/bin
rm -rf /v2ray

cat << EOF > /config.json
{
  "inbounds": [
    {
      "port": $PORT,
      "listen": "0.0.0.0",
      "protocol": "$PROTOCOL",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "level": 0
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/$REQ_PATH/"
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

v2ray -c /config.json