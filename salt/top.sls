base:
  'salt-master':
     - cloud_state
  'roles:strudel_build':
     - match: grain
     - strudel_build
  'roles:vncserver':
     - match: grain
     - vncserver
