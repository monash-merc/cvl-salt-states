base:
  '*':
     - ssh_server

  'roles:strudel_build':
     - match: grain
     - strudel_build
  'roles:vncserver':
     - match: grain
     - vncserver
  'roles:desktop':
     - match: grain
     - desktop
