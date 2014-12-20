#!/bin/bash -x
function get_uuid () { cat - | grep " id " | awk '{print $4}'; }
export MY_C13_NET=`neutron net-show serf-consul-net | get_uuid`

nova boot --flavor standard.xsmall --image "centos-base" \
    --key-name key-for-internal --user-data userdata_app.txt \
    --availability-zone az1 \
    --security-groups sg-for-chap13 --nic net-id=${MY_C13_NET} \
    serf-app01

nova boot --flavor standard.xsmall --image "centos-base" \
    --key-name key-for-internal --user-data userdata_dbs.txt \
    --availability-zone az1 \
    --security-groups sg-for-chap13 --nic net-id=${MY_C13_NET} \
    serf-dbs01
