#!/bin/bash -x
consul watch -http-addr=127.0.0.1:8500 -type=service -service=mysql /opt/consul/consul_watch.sh
