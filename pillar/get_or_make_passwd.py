import random
import sys
import string
def get_existing_passwd(f,passname):
    f.seek(0)
    for line in f.readlines():
        (key,passwd)=line.split(':')
        if key==passname:
            f.close()
            return passwd.rstrip()
    return None

def mk_passwd(f,passname):
    passwd=''.join(random.choice(string.ascii_uppercase + string.digits+string.ascii_lowercase) for _ in range(32))
    f.write("%s:%s\n"%(passname,passwd))
    return passwd
   

def get_passwd(passname):
    f=open('/srv/passwd.txt','at+')
    passwd = get_existing_passwd(f,passname)
    if passwd == None:
        passwd = mk_passwd(f,passname)
    f.close()
    return passwd
