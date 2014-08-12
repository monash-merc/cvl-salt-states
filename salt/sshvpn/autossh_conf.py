def run():
    desktops = salt['mine.get']('roles:desktop','network.ip_addrs',expr_form='grain').items()
    massiveldaptunnelservers = salt['mine.get']('roles:massive_ldap_tunnel','network.ip_addrs',expr_form='grain').items()
    homeservers = salt['mine.get']('roles:share_home','network.ip_addrs',expr_form='grain').items()
    softwareservers = salt['mine.get']('roles:share_software','network.ip_addrs',expr_form='grain').items()
    loginservers = salt['mine.get']('roles:login','network.ip_addrs',expr_form='grain').items()
    glusterservers = salt['mine.get']('roles:gluster_server','network.ip_addrs',expr_form='grain').items()
    schedulers = salt['mine.get']('roles:scheduler','network.ip_addrs',expr_form='grain').items()


    config=""
    i=7000
    for (host,ips) in homeservers:
        config=config+"%s,%s,2049,localhost,2049,%s\n"%(i,host+"-loop",host)
        i=i+1
    for (host,ips) in softwareservers:
        config=config+"%s,%s,2049,localhost,2049,%s\n"%(i,host+"-loop",host)
        i=i+1
    for (host,ips) in massiveldaptunnelservers:
        config=config+"%s,%s,1636,localhost,1636,%s\n"%(i,host+"-loop",host)
        i=i+1
    maxport=24009+len(glusterservers)
    for (host,ips) in glusterservers:
        for port in range(24007,maxport):
            config=config+"%s,%s,port,localhost,port,%s\n"%(i,host+"-loop",host)

    return config
