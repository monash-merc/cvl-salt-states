strudel_build:
  {% if grains['os'] == 'CentOS' %}
  build_user: ec2-user
#  install_deps_cmd: ./install_centos6_64bit_prerequisites.sh
  install_deps_cmd: echo installing dependencies
  pkg_deps:
    - gcc
    - python-pip
    - python-devel
    - python-paramiko
    - wxPython
    - rpm-build
    - gmp-devel
    - mpir-devel
    - python-requests
    - python-urllib3
    - python-psutil
    - python-lxml
  pip_pkg_deps:
    - appdirs
    - pexpect
  build_pkg_cmd: "./package_centos_version.sh"
  python-wxgtk: wxPython
  {% elif grains['os'] == 'Debian' %}
  build_user: debian
  #install_deps_cmd: ./install_debian_64bit_prerequisites.sh
  install_deps_cmd: echo installing dependencies
  build_pkg_cmd: ./package_debian_version.sh
  {% elif grains['os'] == 'Ubuntu' %}
  build_user: ubuntu
#  pkg_deps:
#    - python-pip
#    - wxPython
#  pip_deps:
#    - ssh
#    - pycrypto
#    - appdirs
#    - requests
#    - pexpect
#    - lxml
#    - psutil
#  install_deps_cmd: ./install_ubuntu_64bit_prerequisites.sh
  build_pkg_cmd: ./package_ubuntu_version.sh
  python-wxgtk: python-wxgtk2.8
  {% endif %}
  
