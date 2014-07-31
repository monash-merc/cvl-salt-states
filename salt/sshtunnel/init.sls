sshtunnel:
  group.present:
    - name: sshtunnel

  user.present:
    - name: sshtunnel
    - gid_from_name: True
    - home: /var/sshtunnel
    - require:
      - group: sshtunnel

sshd:
  service.running:
    - name: sshd
    - watch:
      - file: sshhostcert
      - file: /etc/ssh/sshd_config

sshkey:
  cmd.run:
    - user: sshtunnel
    - name: mkdir -p /var/sshtunnel/.ssh && chmod 700 /var/sshtunnel/.ssh && ssh-keygen -t rsa -f /var/sshtunnel/.ssh/id_rsa -N ""
    - unless: "ls /var/sshtunnel/.ssh/id_rsa"
    - creates: /var/sshtunnel/.ssh/id_rsa
    - require:
      - user: sshtunnel

sshusercert:
  file.managed:
    - name: /var/sshtunnel/.ssh/id_rsa-cert.pub
    - user: sshtunnel
    - group: sshtunnel
    - source: salt://{{ grains['host'] }}_sshtunnel-cert.pub
    - require:
      - cmd: sshkey

sshhostcert:
  file.managed:
    - name: /etc/ssh/ssh_host_rsa_key-cert.pub
    - user: sshtunnel
    - group: sshtunnel
    - source: salt://{{ grains['host'] }}-cert.pub

sshknownhosts:
  file.managed:
    - name: /etc/ssh/ssh_known_hosts
    - user: root
    - group: root
    - source: salt://ssh_known_hosts

sshTrustedUserCAKey:
  file.managed:
    - name: /etc/ssh/user_ca_key.pub
    - user: root
    - group: root
    - source: salt://user_ca_key.pub

/etc/ssh/sshd_config:
  file.managed:
    - source: salt://sshtunnel/sshd_config
