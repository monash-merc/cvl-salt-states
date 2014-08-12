#!py
def get_block():
    massiveldaptunnelservers = salt['mine.get']('roles:massive_ldap_tunnel','network.ip_addrs',expr_form='grain').items()
    allnodes = salt['mine.get']('*','network.ip_addrs').items()
    
    deployment = salt['grains.get']('deployment')
    domain = salt['grains.get']('domain')
    hostsstring=""


    hostsstring=hostsstring+"\n"

    i=1
    excludehosts=[]
    for (host,ips) in massiveldaptunnelservers:
        excludehosts.append(host)
        if "0" in host:
            endpoint="m1-w.massive.org.au"
        else:
            endpoint="m2-w.massive.org.au"

        hostsstring=hostsstring+"\n127.0.7.%s %s %s"%(i,host+"-loop",endpoint)
        i=i+1
    hostsstring=hostsstring+"\n"

    for (host,ips) in allnodes:
        hostfqdn=host+".%s"%domain
        for ip in ips:
            hostsstring=hostsstring+"\n%s %s %s"%(ip,hostfqdn,host)
        if not host in excludehosts:
            hostsstring=hostsstring+"\n127.0.2.%s %s"%(i,host+"-loop")

    return hostsstring

def run():
    config={}
    hostsstring=get_block()
    config['hosts']={'file.blockreplace':[{'name':'/etc/hosts'},{'append_if_not_found':'True'},{'content':hostsstring}]}
    return config
