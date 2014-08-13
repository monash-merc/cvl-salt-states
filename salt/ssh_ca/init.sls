#!py

def get_names(server,ipaddr_list):
    for (name,addr) in ipaddr_list:
        if name==server:
            return "%s,%s"%(server,addr[0])

def sign_key(server,key,names):
    function=[]
    function.append('run')
    function.append({'name':'echo "%s" > /srv/salt/%s.pub && ssh-keygen -s /srv/host_ca_key -I host_ca -h -n %s /srv/salt/%s.pub'%(key,server,names,server)})
    function.append({'require':[{'cmd':'create_known_hosts'}]})
    function.append({'creates':"/srv/salt/%s-cert.pub"%server})
    return {'cmd':function}

def sign_user_key(server,key,names):
    function=[]
    function.append('run')
    function.append({'name':'echo "%s" > /srv/salt/%s_sshtunnel.pub && ssh-keygen -s /srv/user_ca_key -I user_ca -n %s /srv/salt/%s_sshtunnel.pub'%(key,server,names,server)})
    function.append({'require':[{'cmd':'create_known_hosts'}]})
    function.append({'creates':"/srv/salt/%s_sshtunnel-cert.pub"%server})
    return {'cmd':function}


def run():
    config={}
    config['include']=['.hostca','.userca']
    servers=salt['publish.runner']('manage.up')
    ipaddr_list = salt['mine.get']('*','network.ip_addrs').items()
    hostkeys=salt['publish.runner']('sshkeys.get_host_keys')
    userkeys=salt['publish.runner']('sshkeys.get_sshtunnel_keys')
    for server in servers:
        names=get_names(server,ipaddr_list)
        if hostkeys.has_key(server):
            config['sign_%s'%server] = sign_key(server,hostkeys[server],names)
        names='sshtunnel'
        if userkeys.has_key(server):
            config['sign_sshtunnel_%s'%server] = sign_user_key(server,userkeys[server],names)
    return config
