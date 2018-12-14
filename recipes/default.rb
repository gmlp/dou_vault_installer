#
# Cookbook:: dou_vault_installer
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


['curl', 'unzip'].each do |pkg|
  package pkg do
    action :install
    retries 3
    retry_delay 5
  end
end

remote_file '/usr/local/bin/jq' do
  source 'https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64'
  mode '1'
  action :create
end

remote_file '/tmp/get-pip.py' do
  source 'https://bootstrap.pypa.io/get-pip.py'
  mode '1'
  action :create
end

execute 'get-pip script is executed' do
  command '/tmp/get-pip.py'
  action :run
end

execute 'install awscli' do
  command 'sudo pip install awscli'
  action :run
end

execute 'install supervisor' do
  command 'sudo pip install supervisor'
  action :run
end

link '/usr/local/bin/supervisorctl' do
  to '/usr/bin/supervisorctl'
  link_type :symbolic
end

link '/usr/local/bin/supervisord' do
  to '/usr/bin/supervisord'
  link_type :symbolic
end

template '/etc/init.d/supervisor' do
  source 'supervisor-initd-script.sh'
  mode '1'
end

directory '/var/log/supervisor' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory '/etc/supervisor' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template "/etc/supervisor/supervisord.conf" do
  source 'supervisord.conf'
end

execute 'Add supervisor' do
  command 'sudo chkconfig --add supervisor'
  action :run
end

execute 'start supervisor' do
  command 'sudo chkconfig supervisor on'
  action :run
end

user 'vault' do
  system true 
  action :create
end

node['dou_vault_installer']['install_paths'].each do |path|
  directory path do
    owner 'vault'
    group 'vault'
    mode '0755'
    recursive true
    action :create
  end
end

remote_file '/tmp/vault.zip' do
  source "https://releases.hashicorp.com/vault/1.0.0/vault_1.0.0_linux_amd64.zip"
  action :create
end

execute 'unzip vault' do
  command 'unzip -d /tmp /tmp/vault.zip'
  action :run
end

execute 'mv vault' do
  command 'mv /tmp/vault /opt/vault/bin/vault'
  action :run
end


file '/opt/vault/bin/vault' do
  owner 'vault'
  group 'vault'
  mode '1'
  action :create
end

link '/usr/local/bin/vault' do
  to '/opt/vault/bin/vault'
  link_type :symbolic
end

template "/opt/vault/bin/run-vault" do
  source 'run-vault'
  owner 'vault'
  group 'vault'
  mode '1'
end

execute 'configure mlock' do
  command 'sudo setcap cap_ipc_lock=+ep /opt/vault/bin/vault'
  action :run
end