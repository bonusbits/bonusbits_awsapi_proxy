name 'bonusbits_awsapi_proxy'
maintainer 'Levon Becker'
maintainer_email 'levon.becker.github@bonusbits.com'
license 'MIT'
description 'Deploy Squid, CloudWatch Logs and Metrics on Amazon Linux EC2 Instance'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.2'
issues_url 'https://github.com/bonusbits/bonusbits_awsapi_proxy/issues'
source_url 'https://github.com/bonusbits/bonusbits_awsapi_proxy'

depends 'bonusbits_library'

%w(
  amazon
).each do |os|
  supports os
end
