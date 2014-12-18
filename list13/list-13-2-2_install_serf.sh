#!/bin/bash
wget -O 0.6.3_linux_amd64.zip https://dl.bintray.com/mitchellh/serf/0.6.3_linux_amd64.zip
unzip ./0.6.3_linux_amd64.zip
mv ./serf /usr/local/bin/serf
