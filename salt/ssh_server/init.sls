#!py


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
    return config
