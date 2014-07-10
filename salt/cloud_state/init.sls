#!py

deployment = 'test'
schedule = {'highstate': {'function': 'state.highstate',
                          'minutes': 3}}
cloud_provider = 'nova-nectar-msss-config'
cloud_provider = 'nectar_monash'
availability_zone = 'monash-01'

servers = {
    'nfs_homedirs': {
        'roles': ['nfs','homedirs'],
        'profile': 'centos65_monash',
	'volumes': [{
            'name': 'nfs_homedirs_salt_test',
            'size': 1}]
    },
}


def run():
    config = {}
    for name, conf in servers.iteritems():
        count = conf.get('count', 1)
        for i in range(1, 1 + count):
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
                    }},
                ]}
            for vol in conf.get('volumes', []):
                volname = "%s-%s" % (deployment, vol['name'])
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
