#!py

def get_names(server):
    for (name,addr) in salt['mine.get']('*','network.ip_addrs').items():
        if name==server:
            return "%s,%s"%(server,addr)

def sign_key(server,key,names):
    function=[]
    function.append('run')
    function.append({'name':'echo "%s" > /srv/salt/%s.pub && ssh-keygen -s /srv/host_ca_key -I host_ca -n %s /srv/salt/%s.pub'%(key,server,names,server)})
    function.append({'require':[{'cmd':'create_known_hosts'}]})
    function.append({'creates':"/srv/salt/%s-cert.pub"%server})
    return {'cmd':function}


def run():
    config={}
    config['include']=['.hostca']
    keys=salt['publish.runner']('sshkeys.get_host_keys')
    for server in keys.keys():
        names=get_names(server)
        config['sign_%s'%server] = sign_key(server,keys[server],names)
    return config
