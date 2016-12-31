# Install & Config Squid
include_recipe 'bonusbits_awsapi_proxy::squid'

# Install & Config CloudWatch Logs for Squid
include_recipe 'bonusbits_awsapi_proxy::logs'

# Create Cron Job for Updating Security Patches Hourly
cron 'yum_update_security' do
  action :create
  minute '0'
  hour '0'
  user 'root'
  command 'yum -y update --security'
end

# Deploy DNS Update Script
# **Last so if anything bombs it doesn't update DNS**
include_recipe 'bonusbits_awsapi_proxy::dns' if node['bonusbits_awsapi_proxy']['dns']['configure']
