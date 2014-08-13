{% if grains['os_family'] == 'RedHat' %}
/etc/sysconfig/network:
    file.managed:
        - template: py
        - source: salt://etc_sysconfig_network/network.py
{% endif %}
