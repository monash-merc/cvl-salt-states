import subprocess
import sys
def autossh_running(echoport,port,bindaddr,destaddr,remoteaddr):
    substr = "autossh -M %s %s:%s:%s:%s %s"%(echoport,bindaddr,port,destaddr,port,remoteaddr)
    import subprocess
    p = subprocess.Popen(['ps','aux'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,stdin=None)
    (stdout,stderr) = p.communicate()
    for l in stdout:
        if substr in l:
            return True
    return False

def main():
    f=open(sys.argv[1],'r')
    for line in f.readlines():
        (echoport,port,bindaddr,destaddr,remoteaddr) = line.rstrip().split(',')
        if not autossh_running(echoport,port,bindaddr,destaddr,remoteaddr):
            subprocess.Popen(['autossh','-f','-M',echoport,'-N','-L','%s:%s:%s:%s'%(bindaddr,port,destaddr,port),remoteaddr])


if __name__ == "__main__":
    main()
