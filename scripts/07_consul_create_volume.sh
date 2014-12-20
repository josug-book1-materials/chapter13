#!/bin/bash -x
function get_uuid () { cat - | grep " id " | awk '{print $4}'; }
cinder create --availability-zone az1 --display-name consul_db01 1
export MY_CONSUL_DB01=`cinder show consul_db01 |get_uuid`
nova volume-attach serf-dbs01 $MY_CONSUL_DB01
