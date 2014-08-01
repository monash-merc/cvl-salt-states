base:
  '*':
     - mine_functions

  'roles:strudel_build':
     - match: grain
     - strudel_build

  'roles:vncserver':
     - match: grain
     - vncserver

  'roles:desktop':
     - match: grain
     - desktop
