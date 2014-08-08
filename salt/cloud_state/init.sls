#!py

cloud_provider = 'nectar_monash'
availability_zone = 'monash-01'
def get_servers(deployment):

    servers = {
    'login': {
        'count': 1,
        'roles': ['login','scheduler','massive_ldap_tunnel','share_home','share_usrlocal'],
        'profile': 'centos65_monash',
        'volumes': [{
                'name': 'cvlhomedirs',
                'size': 1}]
    },
    'desktop': {
        'count': 1,
        'roles': ['desktop'],
        'profile': 'centos65_monash',
    },
}
    return servers


def write_userdata_file(filename,configname,domain):
    f=open(filename,'w')
    f.write('hostname: %s\n'%configname)
    f.write('fqdn: %s.%s\n'%(configname,domain))
    f.close()

def run():
    config = {}
    deployment = salt['grains.get']('deployment')
    domain = salt['grains.get']('domain')
    if deployment == None or deployment == '':
      deployment = 'test'
    domain="massive.org.au"
    servers=get_servers(deployment)
    for name, conf in servers.iteritems():
        count = conf.get('count', 1)
        for i in range(0, count):
            config_name = "%s-%s-%d" % (deployment,
                                        name,
                                        i)
            roles = conf['roles']
            profile_name = '%s' % (conf['profile'])
            userdata_file = "/tmp/"+config_name+"-cloud-config.txt"
            write_userdata_file(userdata_file,config_name,domain)
            config[config_name] = {
                'cloud': [
                    'profile',
                    {'profile': profile_name},
                    {'cloud_provider': cloud_provider},
                    {'availability_zone': availability_zone},
                    {'userdata_file:':userdata_file},
                    {'minion': {
                        'grains': {
                            'deployment': deployment,
                            'domain': domain,
                            'roles': roles,
                        },
                        'master': grains['ipv4'][0]
                    }},
                ]}
            for vol in conf.get('volumes', []):
                volname = "%s-%s-%s" % (deployment, vol['name'],count)
                config[volname + '-vol-present'] = {
                    'cloud.volume_present': [
                        {'name': volname},
                        {'provider': cloud_provider},
                        {'availability_zone': availability_zone},
                        {'size': vol['size']},
                        {'require_in': [{'cloud': config_name}]},
                    ]
                }
                config[volname + '-vol-attached'] = {
                    'cloud.volume_attached': [
                        {'name': volname},
                        {'server_name': config_name},
                        {'device': ''},
                        {'provider': cloud_provider},
                        {'require': [
                            {'cloud': volname + '-vol-present'},
                            {'cloud': config_name}, ]
                         },
                    ]}
    return config
