base:
  '*':
     - ssh_server

  'salt-master':
     - cloud_state
     - ssh_ca

  'roles:strudel_build':
     - match: grain
     - strudel_build

  'roles:vncserver':
     - match: grain
     - vncserver

  'roles:nfs':
     - match: grain
     - nfs

  'roles:desktop':
     - match: grain
     - desktop

  'roles:share_home':
     - match: grain
     - share_home
