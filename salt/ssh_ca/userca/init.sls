create_userca:
  cmd.run:
    - name: ssh-keygen -f /srv/user_ca_key -P ""
    - creates: /srv/user_ca_key

create_trusted_user_ca_key:
  cmd.run:
     - name: cp /srv/user_ca_key.pub /srv/salt/user_ca_key.pub
     - creates: /srv/salt/user_ca_key.pub
