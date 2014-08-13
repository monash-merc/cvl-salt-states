def run():
    contents=""
    domain = salt['grains.get']('domain')
    node = salt['grains.get']('nodename').split('.')[0]
    contents=contents+"NETWORKING=yes\n"
    contents=contents+"HOSTNAME=%s.%s\n"%(node,domain)
    return contents
