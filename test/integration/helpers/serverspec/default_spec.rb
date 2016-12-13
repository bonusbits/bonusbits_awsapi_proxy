require 'spec_helper'

describe 'Default Recipe' do
  it chef_client_version do
    expect(command('knife -v').stdout).to contain(chef_client_version)
  end
end
