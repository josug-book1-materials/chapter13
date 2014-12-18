#!/bin/bash
if [ -e /opt/consul/failover.log ]; then
     exit 0;
fi
date > /opt/consul/failover.log
source /root/openrc
function get_uuid () { cat - | grep " id " | awk '{print $4}'; }
export MY_CONSUL_SNAP=`cinder snapshot-show consul_db01_snap | get_uuid`
cinder create --snapshot-id ${MY_CONSUL_SNAP} --display-name consul_db01_copy 1
export MY_C13_NET=`neutron net-show serf-consul-net | get_uuid`
export MY_CONSUL_VOLUME=`cinder show consul_db01_copy | get_uuid`
export MY_CONSUL_SERVER=`nova show serf-step-server | \
    grep " serf-consul-net" |awk '{print$5}' | sed -e "s/,//g"`

nova boot --flavor standard.xsmall \
    --image "centos-base" \
    --key-name key-for-internal \
    --security-groups sg-for-chap13 \
    --nic net-id=${MY_C13_NET} \
    --availability-zone az1 \
    --user-data /root/userdata_consul-dbs.txt \
    --meta CONSUL_SERVER=${MY_CONSUL_SERVER} \
    --block-device-mapping vdc=${MY_CONSUL_VOLUME}:::false \
    serf-dbs02

