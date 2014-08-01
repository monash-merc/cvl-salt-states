/etc/hosts:
  file.managed:
    - name: /etc/hosts
    - user: root
    - group: root
    - template: py
    - source: salt://hosts/hosts.py
