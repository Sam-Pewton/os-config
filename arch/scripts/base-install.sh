#!/usr/bin/bash

ansible-playbook -i ./ansible/inventory ./ansible/setup.yaml --ask-become-pass --ask-pass
