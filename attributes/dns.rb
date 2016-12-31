default['bonusbits_awsapi_proxy']['dns'].tap do |dns|
  dns['configure'] = false
  dns['ttl'] = '60'
end
