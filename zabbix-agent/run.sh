#!/bin/bash
set -e

CONFIG_PATH=/data/options.json
CUSTOM_CFG_PATH=/share/zabbix-agent

SERVER=$(jq --raw-output ".server" $CONFIG_PATH)
HOSTNAME=$(jq --raw-output ".hostname" $CONFIG_PATH)

if [ ! -d "$CUSTOM_CFG_PATH" ] ; then
  mkdir -p "$CUSTOM_CFG_PATH"
fi

exec chmod 660 /dev/vchiq
exec chown root:video /dev/vchiq


echo "
Server=$SERVER
ServerActive=$SERVER
Hostname=$HOSTNAME
LogType=console
Include=${CUSTOM_CFG_PATH}/*.conf
" > /etc/zabbix/zabbix_agentd.conf

exec su zabbix -s /bin/ash -c "/usr/sbin/zabbix_agentd -f"
