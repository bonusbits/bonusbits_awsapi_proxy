require 'spec_helper'

describe 'bonusbits_awsapi_proxy::squid' do
  context 'Create Directory' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'amazon', version: '2016.03')
      runner.converge(described_recipe)
    end
    it 'Downloads Directory' do
      expect(chef_run).to create_directory('/opt/chef-repo/downloads')
    end
  end
  context 'Install Squid' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'amazon', version: '2016.03')
      runner.converge(described_recipe)
    end
    it 'Download Squid RPM' do
      expect(chef_run).to run_ruby_block('Download Squid RPM')
    end
    it 'Install Squid RPM' do
      expect(chef_run).to install_yum_package('Install Squid Local RPM')
    end
    it 'Deploy Squid Config Template' do
      expect(chef_run).to create_template('/etc/squid/squid.conf')
    end
    it 'Enable Squid Service' do
      expect(chef_run).to enable_service('squid')
    end
  end
end
