nfsclient:
  pkg.installed:
    - name: nfs-utils

mount_home:
  mount.mounted:
    - device: {{ salt['mine.get']('roles:share_home','network.ip_addrs', expr_form='grain').items()[0][1][0] }}:/
    - fstype: nfs
    - name: /home
    - require:
      - pkg: nfsclient

#  cmd:
#    - run
#    - name: echo {{ salt['mine.get']('roles:share_home','network.ip_addrs', expr_form='grain').items()[0][1][0] }}
