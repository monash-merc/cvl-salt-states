#!py

deployment = grains['deployment']
if deployment == None or deployment == '':
  deployment = 'test'
schedule = {'highstate': {'function': 'state.highstate',
                          'minutes': 3}}
cloud_provider = 'nectar_monash'
availability_zone = 'monash-01'

servers = {
    'cvlhomeserver': {
        'count': 1,
        'roles': ['share_home'],
        'profile': 'centos65_monash',
        'volumes': [{
                'name': 'cvlhomedirs',
                'size': 1}]
    },
    'cvlsoftwareserver': {
        'count': 0,
        'roles': ['share_usrlocal'],
        'profile': 'centos65_monash',
        'volumes': [{
                'name': 'cvlsoftwareserver',
                'size': 1}]
        },
    'cvlldap': {
        'count': 0,
        'roles': ['ldap'],
        'profile': 'centos65_monash',
    },
    'cvllogin': {
        'count': 0,
        'roles': ['login','scheduler'],
        'profile': 'centos65_monash',
    },
    'cvldesktop': {
        'count': 0,
        'roles': ['desktop'],
        'profile': 'centos65_monash',
    },
}


def run():
    config = {}
    for name, conf in servers.iteritems():
        count = conf.get('count', 1)
        for i in range(0, count):
            config_name = "%s-%s-%d" % (deployment,
                                        name,
                                        i)
            roles = conf['roles']
            if 'single_roles' in conf:
                if i == count:
                    while len(conf['single_roles']) > 0:
                        roles.append(conf['single_roles'].pop())
                else:
                    roles.append(conf['single_roles'].pop())
            profile_name = '%s' % (conf['profile'])
            config[config_name] = {
                'cloud': [
                    'profile',
                    {'profile': profile_name},
                    {'cloud_provider': cloud_provider},
                    {'availability_zone': availability_zone},
                    {'minion': {
                        'grains': {
                            'deployment': deployment,
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
