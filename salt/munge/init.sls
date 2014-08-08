wget:
  pkg.installed:
    - name: wget

openssl:
  pkg.installed:
    - name: openssl-devel

bzip2-devel:
  pkg.installed:
    - name: bzip2-devel

gcc:
  pkg.installed:
    - name: gcc

rpmbuild:
  pkg.installed:
    - name: rpm-build

get_source:
  cmd.run:
    - name: "cd /tmp ; wget https://munge.googlecode.com/files/munge-0.5.11.tar.bz2"
    - require: 
      - pkg: wget
    - creates: /tmp/munge-0.5.11.tar.bz2
    - unless: ls /tmp/munge-0.5.11.tar.bz2
  
make_rpm:
  cmd.run:
    - name: "cd /tmp ; rpmbuild -tb --clean munge-0.5.11.tar.bz2"
    - require: 
      - pkg: rpmbuild
      - pkg: bzip2-devel
      - pkg: gcc
      - cmd: get_source
    - unless: ls /root/rpmbuild/RPMS/x86_64/munge*rpm

munge_installed:
  pkg.installed:
    - sources:
      - munge: /root/rpmbuild/RPMS/x86_64/munge-0.5.11-1.el6.x86_64.rpm
      - munge-devel: /root/rpmbuild/RPMS/x86_64/munge-devel-0.5.11-1.el6.x86_64.rpm
      - munge-libs: /root/rpmbuild/RPMS/x86_64/munge-libs-0.5.11-1.el6.x86_64.rpm
    - require:
      - cmd: make_rpm

munge_key:
  file.managed:
    - source: salt://munge/key
    - template: jinja
    - name: /etc/munge/munge.key

munge_started:
  service.running:
    - name: munge
    - require:
      - file: munge_key
      - pkg: munge_installed
