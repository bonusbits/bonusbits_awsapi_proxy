default['bonusbits_awsapi_proxy']['squid'].tap do |squid|
  squid['user'] = 'squid'
  squid['group'] = 'squid'

  squid['rpm_filename'] = 'squid-3.5.11-1.el6.x86_64.rpm'
  squid['port'] = '3128'
end
