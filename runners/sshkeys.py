#!/usr/bin/python
# Import salt modules
import salt.client

def get_host_keys(tgt='*'):
    client = salt.client.LocalClient(__opts__['conf_file'])
    minions = client.cmd(tgt, 'cmd.run',['cat /etc/ssh/ssh_host_rsa_key.pub'],timeout=0)
    return minions

def get_sshtunnel_keys(tgt='*'):
    client = salt.client.LocalClient(__opts__['conf_file'])
    minions = client.cmd(tgt, 'cmd.run',['cat /var/sshtunnel/.ssh/id_rsa.pub'],timeout=0)
    res={}
    for minion in minions.keys():
        if not "No such file" in minions[minion]:
            res[minion]=minions[minion]

    return res
