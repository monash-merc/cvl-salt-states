include:
  - sshvpn

nfsclient:
  pkg.installed:
    - name: nfs-utils

mount_home:
  mount.mounted:
    - device: {{ salt['mine.get']('roles:share_home','grains.item',expr_form='grain').items()[0][0] }}-loop:/
    - fstype: nfs4
    - name: /home
    - opts: proto=tcp,port=2049,hard,intr
    - require:
      - pkg: nfsclient
      - cmd: start_autossh
