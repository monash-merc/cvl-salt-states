def run():
    clients = salt['mine.get']('roles:desktop','network.ip_addrs',expr_form='grain').items()
    ipaddrs=['127.0.0.1']
    contents="/mnt/home "
    opts="(rw,no_root_squash,fsid=0,sync,insecure,insecure_lock)"
    for i in ipaddrs:
        contents=contents+" %s%s"%(i,opts)
    return contents
