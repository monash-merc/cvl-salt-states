home_fs:
  pkg.installed:
    - name: xfsprogs
  cmd.run:
    - name: mkfs.xfs /dev/vdc || exit 0
    - require:
      - pkg: home_fs

/mnt/home:
  mount.mounted:
    - device: /dev/vdc
    - fstype: xfs
    - mkmnt: True
    - require:
      - cmd: home_fs

/etc/exports:
  file.managed:
      - user: root
      - group: root
      - template: py
      - source: salt://share_home/exports.py

rpcbind:
  service.running:
    - name: rpcbind
    - require:
      - pkg: nfs

nfs:
  pkg.installed:
    - name: nfs-utils
  service.running:
    - name: nfs
    - require:
      - mount: /mnt/home
      - service: rpcbind
    - watch: 
      - file: /etc/exports
       
