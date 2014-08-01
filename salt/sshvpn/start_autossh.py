import subprocess
def autossh_running(echoport,port,bindaddr,remoteaddr):
    substr = "autossh -M %s %s:%s:localhost:%s %s"%(echoport,bindaddr,port,port,remoteaddr)
    import subprocess
    p = subprocess.Popen(['ps','aux'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,stdin=None)
    (stdout,stderr) = p.communicate()
    for l in stdout:
        if substr in l:
            return True
    return False

def main():
    f=open("/etc/autossh.conf",'r')
    for line in f.readlines():
        (echoport,port,bindaddr,remoteaddr) = line.rstrip().split(',')
        if not autossh_running(echoport,port,bindaddr,remoteaddr):
            subprocess.Popen(['autossh','-f','-M',echoport,'-N','-L','%s:%s:localhost:%s'%(bindaddr,port,port),remoteaddr])


if __name__ == "__main__":
    main()
