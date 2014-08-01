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
    hostsstring="""
127.0.0.1 localhost %s %s
127.0.1.1 ubuntu.localhost ubuntu

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
    """%(me+"-loop",myrole)


    i=1
    for (host,ips) in ldapservers:
        if host == me:
            continue
        role=host.split(deployment+"-")[1]
        hostsstring=hostsstring+"\n127.0.2.%s %s %s"%(i,host+"-loop",role)
        i=i+1
        for ip in ips:
            hostsstring=hostsstring+"\n %s %s"%(ip,host)

    i=1
    for (host,ips) in homeservers:
        if host == me:
            continue
        role=host.split(deployment+"-")[1]
        hostsstring=hostsstring+"\n127.0.3.%s %s %s"%(i,host+"-loop",role)
        i=i+1
        for ip in ips:
            hostsstring=hostsstring+"\n%s %s"%(ip,host)

    i=1
    for (host,ips) in softwareservers:
        if host == me:
            continue
        role=host.split(deployment+"-")[1]
        hostsstring=hostsstring+"\n127.0.4.%s %s %s"%(i,host+"-loop",role)
        i=i+1
        for ip in ips:
            hostsstring=hostsstring+"\n%s %s"%(ip,host)

    i=1
    for (host,ips) in loginservers:
        if host == me:
            continue
        role=host.split(deployment+"-")[1]
        hostsstring=hostsstring+"\n127.0.5.%s %s %s"%(i,host+"-loop",role)
        i=i+1
        for ip in ips:
            hostsstring=hostsstring+"\n%s %s"%(ip,host)

    i=1
    for (host,ips) in schedulers: 
        if host == me:
            continue
        role=host.split(deployment+"-")[1]
        hostsstring=hostsstring+"\n127.0.6.%s %s %s"%(i,host+"-loop",role)
        i=i+1
        for ip in ips:
            hostsstring=hostsstring+"\n%s %s"%(ip,host)

    i=1
    for (host,ips) in desktops:
        if host == me:
            continue
        role=host.split(deployment+"-")[1]
        hostsstring=hostsstring+"\n127.1.0.%s %s %s"%(i,host+"-loop",role)
        i=i+1
        for ip in ips:
            hostsstring=hostsstring+"\n%s %s"%(ip,host)
    hostsstring=hostsstring+"\n"

    return hostsstring
