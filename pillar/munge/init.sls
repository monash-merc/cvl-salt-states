#!py
import sys
def run():
    sys.path.append('/srv/pillar/')
    from get_or_make_passwd import get_passwd
    config={}
    config['munge']={}
    config['munge']['key'] = get_passwd('munge')
    return config
