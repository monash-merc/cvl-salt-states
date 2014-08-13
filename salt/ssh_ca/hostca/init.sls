create_hostca:
  cmd.run:
    - name: ssh-keygen -f /srv/host_ca_key -P ""
    - creates: /srv/host_ca_key

create_known_hosts:
  cmd.run:
    - name: echo "@cert-authority *" ` cat /srv/host_ca_key.pub ` > /srv/salt/ssh_known_hosts
    - create: /srv/salt/ssh_known_hosts
    - require:
      - cmd: create_hostca
