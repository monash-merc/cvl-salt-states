
{% for pkg_name in salt['pillar.get']('strudel_build:pkg_deps') %}
{{ pkg_name }}:
  pkg:
    - name: {{ pkg_name }}
    - installed
{% endfor %}

{% for pip_pkg_name in salt['pillar.get']('strudel_build:pip_pkg_deps') %}
{{ pip_pkg_name }}:
  pip:
    - name: {{ pip_pkg_name }}
    - installed
{% endfor %}

install_deps:
  cmd:
    - run
    - cwd: /tmp/strudel/system_build_scripts/
    - name: {{ salt['pillar.get']('strudel_build:install_deps_cmd') }}
    - require:
      {% for pkg_name in salt['pillar.get']('strudel_build:pkg_deps') %}
      - pkg: {{ pkg_name }}
      {% endfor %}
      {% for pip_pkg_name in salt['pillar.get']('strudel_build:pip_pkg_deps') %}
      - pip: {{ pip_pkg_name }}
      {% endfor %}
      - git: checkout_launcher
      - pkg: install_curl
      - pkg: install_wget
      - pkg: python-wxgtk

build_launcher:
  cmd:
    - run
    - cwd: /tmp/strudel/
    - name: {{ salt['pillar.get']('strudel_build:build_pkg_cmd','./package_linux_version.sh') }}
    - user: {{ salt['pillar.get']('strudel_build:build_user', 'root') }}
    - require:
      - cmd: install_deps
      - git: checkout_launcher 
      - pkg: install_binutils

checkout_launcher:
  git.latest:
    - name: https://github.com/monash-merc/cvl-fabric-launcher.git
    - rev: master
    - user: {{ salt['pillar.get']('strudel_build:build_user', 'root') }}
    - target: /tmp/strudel
    - submodules: True
    - require:
      - pkg: install_git

python-wxgtk:
  pkg:
    - name: {{ salt['pillar.get']('strudel_build:python-wxgtk', 'python-wxgtk2.8') }}
    - installed

install_git:
  pkg:
    - name: git
    - installed
install_curl:
  pkg:
    - name: curl 
    - installed
install_wget:
  pkg:
    - name: curl 
    - installed

install_binutils:
  pkg:
    - name: binutils
    - installed
