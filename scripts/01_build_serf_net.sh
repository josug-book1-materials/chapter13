#!/bin/bash -x

neutron net-create serf-consul-net
neutron subnet-create --ip-version 4 --gateway 10.20.0.254 \
  --name serf-consul-subnet serf-consul-net 10.20.0.0/24
neutron router-interface-add Ext-Router serf-consul-subnet
neutron security-group-create sg-for-chap13
neutron security-group-rule-create --ethertype IPv4 --protocol tcp \
  --remote-ip-prefix 10.20.0.0/24 sg-for-chap13
neutron security-group-rule-create --ethertype IPv4 --protocol udp \
  --remote-ip-prefix 10.20.0.0/24 sg-for-chap13
neutron security-group-rule-create --ethertype IPv4 --protocol icmp \
  --remote-ip-prefix 10.20.0.0/24 sg-for-chap13
neutron security-group-rule-create --ethertype IPv4 --protocol tcp \
  --port-range-min 22 --port-range-max 22 --remote-ip-prefix 0.0.0.0/0 sg-for-chap13
