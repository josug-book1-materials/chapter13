#!/bin/bash -x

yum install -y jq
mkdir -p /opt/consul/conf /opt/consul/dat
CONSUL_SERVER=`curl -s http://169.254.169.254/openstack/latest/meta_data.json | jq -r '.meta["CONSUL_SERVER"]'`
/usr/local/bin/consul agent \
    -dc=openstack \
    -data-dir=/opt/consul/dat \
    -config-file=/opt/consul/conf \
    -join=${CONSUL_SERVER}
