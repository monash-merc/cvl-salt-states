#!py
def loop_mine():
    ipaddrs=" list of ipaddrs:\n"
    for (server,addr) in salt['mine.get']('*','network.ip_addrs').items():
        ipaddrs=ipaddrs+" server %s, address %s \n"%(server,addr)
    function=['run',{'name':'echo %s'%ipaddrs}]
    return {'cmd':function}


def set_hostkey_as_grain():
    import subprocess
    p=subprocess.Popen(['cat','/etc/ssh/ssh_host/ssh_host_rsa_key.pub'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,stdin=None)
    (stdout,stderr)=p.communicate()
    rsapubkey=stdout
    function=['present',{'name':'ssh_host_rsa_key.pub'},{'value':'%s'%rsapubkey}]
    return {'grains':function}


def run():
    config={}
#    config['hostkey_grain'] = set_hostkey_as_grain() 
    config['test'] = loop_mine()
    return config
