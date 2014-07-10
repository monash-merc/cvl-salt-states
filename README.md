cvl-salt-states
===============
This repository is for use with saltstack
it contains
1) Our profiles descriping the flavours that we can instantiate on NeCTAR Openstack
2) An sls desribing what VMs we want running and what roles the fill
3) The sls files describing how to fill each role

Assuming you have a computer with salt-master installed on it you need to 
a) Configure a provider in /etc/salt/cloud.providers.d
b) symlink /etc/salt/cloud.profiles.d to the profiles directory in this repo
c) either configer /etc/salt-master to point base and pillars at the other directories, or symlink them as well
