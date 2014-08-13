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

slurm_installed:
  pkg.installed:
    - source:
      - slurm: /root/rpmbuild/RPMS/x86_64/slurm-14.03.6-1.el6.x86_64.rpm
      - slurm-devel: /root/rpmbuild/RPMS/x86_64/slurm-devel-14.03.6-1.el6.x86_64.rpm
      - slurm-munge: /root/rpmbuild/RPMS/x86_64/slurm-munge-14.03.6-1.el6.x86_64.rpm
      - slurm-pam_slurm: /root/rpmbuild/RPMS/x86_64/slurm-pam_slurm-14.03.6-1.el6.x86_64.rpm
      - slurm-perlapi: /root/rpmbuild/RPMS/x86_64/slurm-perlapi-14.03.6-1.el6.x86_64.rpm
      - slurm-plugins: /root/rpmbuild/RPMS/x86_64/slurm-plugins-14.03.6-1.el6.x86_64.rpm
      - slurm-sjobexit: /root/rpmbuild/RPMS/x86_64/slurm-sjobexit-14.03.6-1.el6.x86_64.rpm
      - slurm-sjstat: /root/rpmbuild/RPMS/x86_64/slurm-sjstat-14.03.6-1.el6.x86_64.rpm
      - slurm-slurmdbd: /root/rpmbuild/RPMS/x86_64/slurm-slurmdbd-14.03.6-1.el6.x86_64.rpm
      - slurm-slurmdb-direct: /root/rpmbuild/RPMS/x86_64/slurm-slurmdb-direct-14.03.6-1.el6.x86_64.rpm
      - slurm-sql: /root/rpmbuild/RPMS/x86_64/slurm-sql-14.03.6-1.el6.x86_64.rpm
      - slurm-torque: /root/rpmbuild/RPMS/x86_64/slurm-torque-14.03.6-1.el6.x86_64.rpm
      - require:
        - cmd: make_rpm
