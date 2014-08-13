#!py
def run():
    name = salt['grains.get']('host')
    return name
