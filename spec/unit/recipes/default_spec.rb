#
# Cookbook:: dou_vault_installer
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'dou_vault_installer::default' do
  platform 'redhat', '7'
  it 'installs depencies' do
      expect(chef_run).to install_package('curl')
      expect(chef_run).to install_package('unzip')
  end

  it 'jq binary is present' do
    expect(chef_run).to create_remote_file('/usr/local/bin/jq')
  end

  it 'get-pip script is present' do
    expect(chef_run).to create_remote_file('/tmp/get-pip.py')
  end

  it 'get-pip script is executed' do
    expect(chef_run).to run_execute('get-pip script is executed')
  end

  it 'install python dependencies' do
    expect(chef_run).to run_execute('install awscli')
    expect(chef_run).to run_execute('install supervisor')
  end

  it 'create a symlinks for supervisor' do
    expect(chef_run).to create_link('/usr/local/bin/supervisorctl')
    expect(chef_run).to create_link('/usr/local/bin/supervisord')
  end

  it 'create supervisor daemon config file' do
    expect(chef_run).to create_template('/etc/init.d/supervisor').with(
      mode: '1'
    )
  end
  
  it 'supervisor log dir exists' do
    expect(chef_run).to create_directory('/var/log/supervisor')
  end

#  node['dou_vault_installer']['supervisorDir'] do |dir|
#    it 'supervisor dir exists' do
#      expect(chef_run).to create_directory("#{dir}/conf.d/")
#    end
#
#    it 'create supervisor config file' do
#      expect(chef_run) create_template("#{dir}/supervisord.conf").with(
#        mode: '1'
#      )
#    end
#  end

  it 'creates a user vault' do 
    expect(chef_run).to create_user('vault').with(system: true)
  end
  
  
    

end