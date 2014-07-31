def run():
    clients = salt['mine.get']('roles:desktop','network.ip_addrs',expr_form='grain').items()
    ipaddrs=[]
    for c in clients:
        ipaddrs.append(c[1][0])
    contents="/mnt/home "
    opts="(rw,no_root_squash,fsid=0,sync)"
    for i in ipaddrs:
        contents=contents+" %s%s"%(i,opts)
    return contents
