base:
  '*':
     - sshtunnel
     - etc_sysconfig_network
     - hosts

  'roles:config-managment':
     - match: grain
     - ssh_ca

#  'roles:strudel_build':
#     - match: grain
#     - strudel_build
#
#  'roles:vncserver':
#     - match: grain
#     - vncserver
#
#  'roles:nfs':
#     - match: grain
#     - nfs

  'roles:desktop':
     - match: grain
     - desktop
     - munge

  'roles:scheduler':
     - match: grain
     - munge

  'roles:share_home':
     - match: grain
     - share_home

  'roles:massive_ldap_tunnel':
     - match: grain
     - massive_ldap_tunnel
