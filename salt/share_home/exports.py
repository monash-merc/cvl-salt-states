def run():
    ipaddrs=['127.0.0.0/16','::1']
    contents="/mnt/home "
    opts="(rw,no_root_squash,fsid=0,sync,insecure)"
    for i in ipaddrs:
        contents=contents+" %s%s"%(i,opts)
    return contents
