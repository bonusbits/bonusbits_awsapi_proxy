default['bonusbits_awsapi_proxy']['logs'].tap do |logs|
  # Default for Kitchen (Set in CFN)
  logs['cloudwatch_log_group'] = 'test-kitchen'
end
