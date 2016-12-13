require 'spec_helper'

describe 'bonusbits_awsapi_proxy::default' do
  context 'Logic Cop' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'amazon', version: '2016.03')
      runner.converge(described_recipe)
    end
    it 'Include Squid Recipe' do
      expect(chef_run).to include_recipe('bonusbits_awsapi_proxy::squid')
    end
  end
end
