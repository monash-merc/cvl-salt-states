def run():
    desktops = salt['mine.get']('roles:desktop','network.ip_addrs',expr_form='grain').items()
    ldapservers = salt['mine.get']('roles:ldap','network.ip_addrs',expr_form='grain').items()
    homeservers = salt['mine.get']('roles:share_home','network.ip_addrs',expr_form='grain').items()
    softwareservers = salt['mine.get']('roles:share_software','network.ip_addrs',expr_form='grain').items()
    loginservers = salt['mine.get']('roles:login','network.ip_addrs',expr_form='grain').items()
    schedulers = salt['mine.get']('roles:scheduler','network.ip_addrs',expr_form='grain').items()


    config=""
    i=7000
    for (host,ips) in homeservers:
        config=config+"%s,%s,%s,localhost,%s\n"%(i,"2049",host+"-loop",host)
        i=i+1
    for (host,ips) in softwareservers:
        config=config+"%s,%s,%s,localhost,%s\n"%(i,"2049",host+"-loop",host)
        i=i+1

    return config
