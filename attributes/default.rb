# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node['chef_environment']
    /dev|qa|stg|prd/.match(node['chef_environment']).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

default['bonusbits_awsapi_proxy'].tap do |root|
  # S3
  root['squid']['download_url'] = 'http://www.squid-cache.org/Versions/v3/3.5/squid-3.5.22.tar.gz'

  # Paths
  root['local_download_path'] = '/opt/chef-repo/downloads'

  # UID
  root['user'] = 'apache'
  root['group'] = 'apache'

  # Data Bag
  root['connections']['data_bag'] = 'bonusbits_awsapi_proxy'
  root['connections']['data_bag_item'] = 'connections'
end
