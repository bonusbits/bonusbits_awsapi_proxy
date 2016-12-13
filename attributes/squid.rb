default['bonusbits_awsapi_proxy']['squid'].tap do |squid|
  # UID
  squid['user'] = 'squid'
  squid['group'] = 'squid'
end
