cvl-salt-states
===============
This repository is for use with saltstack
it contains
1) Our profiles descriping the flavours that we can instantiate on NeCTAR Openstack
2) An sls in "cloud_state" desribing what VMs we want running and what roles they fill
3) The sls files describing how to fill each role

Assuming you have a computer with salt-master installed on it you need to 
a) Configure a provider in /etc/salt/cloud.providers.d
b) symlink /etc/salt/cloud.profiles.d to the profiles directory in this repo
c) symlink  /srv/runners to runners, /srv/pillar to pillar, /srv/salt to salt.
d) symlink /etc/salt/master to master
e) add the grain "role: config-managment" to this nodes minion

Be aware that our top file assumes at least one node (this one) has a role grain specifying "config-managment" and is running
a version of the salt minion checked out from git. Also it should have python-novaclient checked out from git
