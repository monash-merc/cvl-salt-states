include:
  - sshtunnel
  - sshvpn

massive_tunnel_conf:
  file.managed:
    - name: /etc/massive_tunnel.conf
    - user: root
    - group: root
    - template: py
    - source: salt://massive_ldap_tunnel/massive_tunnel.py

start_massive_tunnel:
  cmd.run:
    - name: python /usr/local/bin/start_autossh.py /etc/massive_tunnel.conf
    - user: sshtunnel
    - require:
      - file: autossh.conf
      - file: start_autossh.py
      - file: sshtunnel_massive_config
      - file: massive_key

sshtunnel_config_exists:
  cmd.run:
    - name: touch /var/sshtunnel/.ssh/config
    - unless: ls /var/sshtunnel/.ssh/config
    
sshtunnel_massive_config:
  file.blockreplace:
    - name: /var/sshtunnel/.ssh/config
    - append_if_not_found: true
    - marker_start: "# MASSIVE config managed by salt start"
    - marker_end: "# MASSIVE config managed by salt end"
    - content: "Host m1.massive.org.au\n    User ssh_tunnel\n    IdentityFile /var/sshtunnel/.ssh/massive_key\n\nHost m2.massive.org.au\n    User ssh_tunnel\n    IdentityFile /var/sshtunnel/.ssh/massive_key"

massive_key:
  file.exists:
    - name: /var/sshtunnel/.ssh/massive_key
