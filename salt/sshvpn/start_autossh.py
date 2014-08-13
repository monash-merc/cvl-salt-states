import subprocess
import sys
def autossh_running(echoport,bindaddr,bindport,destaddr,destport,remoteaddr):
    substr = "-M %s %s:%s:%s:%s %s"%(echoport,bindaddr,bindport,destaddr,destport,remoteaddr)
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
        (echoport,bindaddr,bindport,destaddr,destport,remoteaddr) = line.rstrip().split(',')
        if not autossh_running(echoport,bindaddr,bindport,destaddr,destport,remoteaddr):
            subprocess.Popen(['autossh','-f','-M',echoport,'-o','Ciphers=arcfour','-N','-L','%s:%s:%s:%s'%(bindaddr,bindport,destaddr,destport),remoteaddr])


if __name__ == "__main__":
    main()
