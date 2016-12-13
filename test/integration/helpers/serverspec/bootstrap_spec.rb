require 'spec_helper'

chef_client_version = '12.15.19'

describe 'Chef Client Installed' do
  it chef_client_version do
    expect(command('knife -v').stdout).to contain(chef_client_version)
  end
end
