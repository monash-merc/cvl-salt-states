#!py
def run():
    config={}
    config['nfsserver']={}
    import subprocess
    p=subprocess.Popen(['cat','/etc/hostname'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,stdin=None)
    (stdout,stderr) = p.communicate()

    config['nfsserver']['ip']=stdout
    return config
#nfsserver.ip("bar")
#nfsserver:
#  ip: bar
