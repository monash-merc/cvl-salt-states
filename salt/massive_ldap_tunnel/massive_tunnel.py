def run():
    if '-0' in salt['grains.get']('nodename'):
        remoteaddr="m1.massive.org.au"
        destaddr="m1-w"
    else:
        remoteaddr="m2.massive.org.au"
        destaddr="m2-w"

    return "8000,localhost,1636,%s,636,%s"%(destaddr,remoteaddr)
