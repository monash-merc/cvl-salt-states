#!py
def get_block():
    desktops = salt['mine.get']('roles:desktop','network.ip_addrs',expr_form='grain').items()
    ldapservers = salt['mine.get']('roles:ldap','network.ip_addrs',expr_form='grain').items()
    homeservers = salt['mine.get']('roles:share_home','network.ip_addrs',expr_form='grain').items()
    softwareservers = salt['mine.get']('roles:share_software','network.ip_addrs',expr_form='grain').items()
    loginservers = salt['mine.get']('roles:login','network.ip_addrs',expr_form='grain').items()
    schedulers = salt['mine.get']('roles:scheduler','network.ip_addrs',expr_form='grain').items()
    allnodes = salt['mine.get']('*','network.ip_addrs').items()
    nodenames = salt['mine.get']('*','grains.item').items()
    
    deployment = salt['grains.get']('deployment')
    domain = salt['grains.get']('domain')
    hostsstring=""

    for (host,ips) in allnodes:
        hostfqdn=host+".%s"%domain
        for ip in ips:
            hostsstring=hostsstring+"\n%s %s %s"%(ip,hostfqdn,host)
    i=1
    for (host,ips) in ldapservers:
        hostsstring=hostsstring+"\n127.0.2.%s %s"%(i,host+"-loop")
        i=i+1


    i=1
    for (host,ips) in homeservers:
        hostsstring=hostsstring+"\n127.0.3.%s %s"%(i,host+"-loop")
        i=i+1

    i=1
    for (host,ips) in softwareservers:
        hostsstring=hostsstring+"\n127.0.4.%s %s"%(i,host+"-loop")
        i=i+1

    i=1
    for (host,ips) in loginservers:
        hostsstring=hostsstring+"\n127.0.5.%s %s"%(i,host+"-loop")
        i=i+1

    i=1
    for (host,ips) in schedulers: 
        hostsstring=hostsstring+"\n127.0.6.%s %s"%(i,host+"-loop")
        i=i+1

    i=1
    for (host,ips) in desktops:
        hostsstring=hostsstring+"\n127.1.0.%s %s"%(i,host+"-loop")
        i=i+1
    hostsstring=hostsstring+"\n"

    return hostsstring

def run():
    config={}
    hostsstring=get_block()
    config['hosts']={'file.blockreplace':[{'name':'/etc/hosts'},{'append_if_not_found':'True'},{'content':hostsstring}]}
    #config['hosts']={'file.blockreplace':[{'name':'/etc/hosts'},{'append_if_not_found':'True'}]}
    config['echo']={'cmd.run':[{'name':'echo hello'}]}
    return config
