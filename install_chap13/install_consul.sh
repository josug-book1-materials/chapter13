#!/bin/sh
wget -O 0.4.1_linux_amd64.zip https://dl.bintray.com/mitchellh/consul/0.4.1_linux_amd64.zip
unzip ./0.4.1_linux_amd64.zip
mv ./consul /usr/local/bin/consul
