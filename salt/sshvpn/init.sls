autossh:
  pkg.installed:
    - name: autossh

autossh.conf:
  file.managed:
    - name: /etc/autossh.conf
    - user: root
    - group: root
    - template: py
    - source: salt://sshvpn/autossh_conf.py

start_autossh.py:
  file.managed:
    - name: /usr/local/bin/start_autossh.py
    - user: root
    - group: root
    - source: salt://sshvpn/start_autossh.py

start_autossh:
  cmd.run:
    - name: python /usr/local/bin/start_autossh.py
    - user: sshtunnel
    - require:
      - file: autossh.conf
      - file: start_autossh.py
