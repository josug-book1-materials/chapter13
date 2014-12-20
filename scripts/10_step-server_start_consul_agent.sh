#!/bin/bash -x

mkdir -p /opt/consul/conf /opt/consul/dat

consul agent \
    -bootstrap \
    -server \
    -node=consul-server \
    -dc=openstack \
    -data-dir=/opt/consul/dat \
    -config-file=/opt/consul/conf
