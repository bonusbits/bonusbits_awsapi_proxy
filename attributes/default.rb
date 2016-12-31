# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node['chef_environment']
    /dev|qa|stg|prd/.match(node['chef_environment']).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

default['bonusbits_awsapi_proxy'].tap do |root|
  # Paths
  root['local_download_path'] = '/opt/chef-repo/downloads'
end
