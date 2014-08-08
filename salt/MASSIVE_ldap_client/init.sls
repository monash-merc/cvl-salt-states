nslcd:
  pkg.installed:
    - name: nss-pam-ldapd

pam_ldap:
  pkg.installed:
    - name: pam_ldap

  service.running:
    - name: nslcd
    - require:
      - file: nslcd.conf
      - file: cacert

{% if grains['os_family'] == 'RedHat' %}
authconfig:
  file.replace:
    - name: /etc/sysconfig/authconfig
    - pattern: USELDAPAUTH=no
    - repl: USELDAPAUTH=yes

  cmd.wait:
    - name: authconfig --updateall
    - watch:
      - file: authconfig

ldap.conf:
  file.managed:
    - name: /etc/pam_ldap.conf
    - source: salt://MASSIVE_ldap_client/pam_ldap.conf

{% endif %}

nslcd.conf:
  file.managed:
    - name: /etc/nslcd.conf
    - user: nslcd
  {% if grains['os_family'] == 'Debian' %}
    - group: nslcd
  {% elif grains['os_family'] == 'RedHat' %}
    - group: ldap
  {% else %}
    - group: root
  {% endif %}
    - mode: 600
    - source: salt://MASSIVE_ldap_client/nslcd.conf
    - require:
      - pkg: nslcd

nsswitch.conf:
  file.managed:
    - name: /etc/nsswitch.conf
    - user: root
    - group: root
    - mode: 644
    - source: salt://MASSIVE_ldap_client/nsswitch.conf

cacert:
  file.managed:
    - name: /etc/ldap/ldapproxy-ca.pem
    - source: salt://MASSIVE_ldap_client/ldapproxy-ca.pem
    - makedirs: True

cacert2:
  file.managed:
    - name: /etc/openldap/certs/cacert.pem
    - source: salt://MASSIVE_ldap_client/cacert.pem
    - makedirs: True

