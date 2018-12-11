default['dou_vault_installer']['dependencies'] = ['curl', 'unzip']
default['dou_vault_installer']['supervisorDir'] = '/etc/supervisor' 
default['dou_vault_installer']['install_paths'] = [
    '/opt/vault/bin',
    '/opt/vault/config',
    '/opt/vault/data',
    '/opt/vault/log',
    '/opt/vault/tls',
    '/opt/vault/scripts',
]
default['poise-python']['provider'] = 'auto'
default['poise-python']['options'] = {}
default['poise-python']['install_python2'] = false