#!/bin/bash -x

function get_uuid () { cat - | grep " id " | awk '{print $4}'; }
export MY_C13_NET=`neutron net-show serf-consul-net | get_uuid`
export MY_SERF_APP_IP=`nova show serf-app01 |grep " serf-consul-net" |awk '{print $5}'`
export MY_SERF_LBS_IP=`nova show serf-nginx |grep " serf-consul-net" |awk '{print $5}'`

nova boot --flavor standard.xsmall \
    --image "centos-base" \
    --key-name key-for-internal \
    --user-data userdata_serf-web.txt \
    --availability-zone az1 \
    --security-groups sg-for-chap13 --nic net-id=${MY_C13_NET} \
    --meta LBS=${MY_SERF_LBS_IP} \
    --meta APP=${MY_SERF_APP_IP} \
    serf-web01
