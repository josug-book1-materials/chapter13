#!/bin/bash
export STATUS=`curl -s http://127.0.0.1:8500/v1/health/checks/mysql | jq -r '.[].Status'`
if [ ! ${STATUS} = "passing" ]; then
    /opt/consul/consul_mysql_recovery.sh
fi
