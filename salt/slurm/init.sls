wget:
  pkg.installed:
    - name: wget

openssl:
  pkg.installed:
    - name: openssl-devel

readline-devel:
  pkg.installed:
    - name: readline-devel

pam-devel:
  pkg.installed:
    - name: pam-devel

perl-ExtUtils-MakeMaker:
  pkg.installed:
    - name: perl-ExtUtils-MakeMaker

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
    - name: "cd /tmp ; wget http://www.schedmd.com/download/latest/slurm-14.03.6.tar.bz2"
    - require: 
      - pkg: wget
    - creates: /tmp/slurm-14.03.6.tar.bz2
    - unless: ls /tmp/slurm-14.03.6.tar.bz2
  
make_rpm:
  cmd.run:
    - name: "cd /tmp ; rpmbuild -ta --clean slurm-14.03.6.tar.bz2"
    - require: 
      - pkg: rpmbuild
      - pkg: gcc
      - pkg: readline-devel
      - pkg: pam-devel
      - pkg: perl-ExtUtils-MakeMaker
      - cmd: get_source
    - unless: ls /root/rpmbuild/RPMS/x86_64/slurm*rpm

