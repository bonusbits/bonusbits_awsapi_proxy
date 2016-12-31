# Create Chef Repo Directory (For testing without CFN)
local_download_path = node['bonusbits_awsapi_proxy']['local_download_path']
directory local_download_path do
  action :create
  recursive true
end

# Deploy Squid RPM
rpm_filename = node['bonusbits_awsapi_proxy']['squid']['rpm_filename']
rpm_local_path = "/opt/chef-repo/downloads/#{rpm_filename}"
cookbook_file rpm_local_path do
  source rpm_filename
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
  mode '0755'
  notifies :restart, 'service[squid]', :delayed
end

# Create Squid Cache Directories if Missing
ruby_block 'Create Squid Cache Directories' do
  block do
    require 'open3'
    bash_command = 'squid -z'
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

# Define Service for Notifications
service 'squid' do
  service_name 'squid'
  action [:enable, :nothing]
end
