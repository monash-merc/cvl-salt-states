#!/usr/bin/python
# Import salt modules
import salt.client

def get_host_keys():
    client = salt.client.LocalClient(__opts__['conf_file'])
    minions = client.cmd('*', 'cmd.run',['cat /etc/ssh/ssh_host_rsa_key.pub'],timeout=0)
    return minions
