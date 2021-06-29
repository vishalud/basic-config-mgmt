#!/usr/bin/env bash

#Run apt-get update as we cant find the needrestart package otherwise
sudo apt-get update -y
# Install needrestart that checks daemons need to be restarted after library upgrades/changes
sudo apt-get install -y needrestart
