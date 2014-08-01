def run():
    desktops = salt['mine.get']('roles:desktop','network.ip_addrs',expr_form='grain').items()
    ldapservers = salt['mine.get']('roles:ldap','network.ip_addrs',expr_form='grain').items()
    homeservers = salt['mine.get']('roles:share_home','network.ip_addrs',expr_form='grain').items()
    softwareservers = salt['mine.get']('roles:share_software','network.ip_addrs',expr_form='grain').items()
    loginservers = salt['mine.get']('roles:login','network.ip_addrs',expr_form='grain').items()
    schedulers = salt['mine.get']('roles:scheduler','network.ip_addrs',expr_form='grain').items()
    me = salt['grains.get']('nodename')
    deployment = salt['grains.get']('deployment')
    try:
        myrole = me.split(deployment+"-")[1]
    except:
        myrole = me


    config=""
    i=7000
    for (host,ips) in homeservers:
        if host == me:
            continue
        role=host.split(deployment+"-")[1]
        config=config+"%s,%s,%s,%s\n"%(i,"2049",role,host)
        i=i+1
    for (host,ips) in softwareservers:
        if host == me:
            continue
        role=host.split(deployment+"-")[1]
        config=config+"%s,%s,%s,%s\n"%(i,"2049",role,host)
        i=i+1

    return config
