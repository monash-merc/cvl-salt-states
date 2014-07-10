install_vnc:
  pkg:
    - name: {{ salt['pillar.get']('vncserver:pkg_name','tightvncserver') }}
    - installed


{% for pkg_name in salt['pillar.get']('vncserver:wm_pkg_name') %}
{{ pkg_name }}:
  pkg:
    - name: {{ pkg_name }}
    - installed
{% endfor %}

{% for pkg_name in salt['pillar.get']('vncserver:fonts') %}
{{ pkg_name }}:
  pkg:
    - name: {{ pkg_name }}
    - installed
{% endfor %}

install_xterm:
  pkg:
    - name: xterm
    - installed
