#!/bin/bash -x

function get_uuid () { cat - | grep " id " | awk '{print $4}'; }
export MY_C13_NET=`neutron net-show serf-consul-net | get_uuid`
nova boot --flavor standard.xsmall \
    --image "centos-base" \
    --key-name key-for-internal \
    --user-data userdata_serf-lbs.txt \
    --security-groups sg-for-chap13 \
    --availability-zone az1 \
    --nic net-id=${MY_C13_NET} \
    serf-nginx
