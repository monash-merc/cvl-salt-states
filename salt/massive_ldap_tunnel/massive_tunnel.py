def run():
    if '-0' in salt['grains.get']('nodename'):
        remoteaddr="m1-m.massive.org.au"
        destaddr="m1-w"
    else:
        remoteaddr="m2-m.massive.org.au"
        destaddr="m2-w"

    return "8000,636,localhost,%s,%s"%(destaddr,remoteaddr)
