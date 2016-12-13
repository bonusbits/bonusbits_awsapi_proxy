# Variables
local_download_path = node['bonusbits_awsapi_proxy']['local_download_path']
deploy_bucket_path = node['bonusbits_awsapi_proxy']['squid']['deploy_bucket_path']
rpm_filename = node['bonusbits_awsapi_proxy']['squid']['rpm_filename']
rpm_download_url = "#{deploy_bucket_path}/#{rpm_filename}"
rpm_local_path = "#{local_download_path}/#{rpm_filename}"
# user = node['bonusbits_awsapi_proxy']['squid']['user']
# group = node['bonusbits_awsapi_proxy']['squid']['group']

# Create Chef Repo Directory (For testing without CFN)
directory local_download_path do
  action :create
  recursive true
end

# Download Squid RPM
ruby_block 'Download Squid RPM' do
  block do
    require 'open3'
    bash_command = "aws s3 cp s3://#{rpm_download_url} #{rpm_local_path} --sse"
    BonusBits::Output.report("Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    BonusBits::Output.report("Open3 Status (#{status})")
    BonusBits::Output.report("Open3 Standard Out (#{out})")
    BonusBits::Output.report("Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.exist?(rpm_local_path) }
end

# Create Squid Cache Directories if Missing
ruby_block 'Create Squid Cache Directories' do
  block do
    require 'open3'
    bash_command = "squid -z"
    BonusBits::Output.report("Open3 BASH Command (#{bash_command})")

    # Run Bash Script and Capture StrOut, StrErr, and Status
    out, err, status = Open3.capture3(bash_command)
    BonusBits::Output.report("Open3 Status (#{status})")
    BonusBits::Output.report("Open3 Standard Out (#{out})")
    BonusBits::Output.report("Open3 Error Out (#{err})")
    raise 'Failed!' unless status.success?
  end
  action :run
  not_if { ::File.exist?('/var/spool/squid/00') }
end

# Install Squid Local RPM
yum_package 'Install Squid Local RPM' do
  source rpm_local_path
  notifies :restart, 'service[squid]', :delayed
end

# Deploy Squid Config
template '/etc/squid/squid.conf' do
  source 'squid.conf.erb'
  owner 'root'
  group 'root'
  mode 00755
  notifies :restart, 'service[squid]', :delayed
end

# Define Service for Notifications
service 'squid' do
  service_name 'squid'
  action [:enable, :nothing]
end
