# Bonusbits AWS API Proxy Chef Cookbook + CloudFormation
[![CircleCI](https://circleci.com/gh/bonusbits/bonusbits_awsapi_proxy.svg?style=svg)](https://circleci.com/gh/bonusbits/bonusbits_awsapi_proxy)
[![Coverage Status](https://coveralls.io/repos/github/bonusbits/bonusbits_awsapi_proxy/badge.svg?branch=master)](https://coveralls.io/github/bonusbits/bonusbits_awsapi_proxy?branch=master)

# Purpose
Deploy an EC2 Instance running Squid 3.5.11 Proxy server on public subnets. 
Configured to allow all private instances in the VPC CIDR Block access to AWS API services and a few DevOps site only (No Full internet access).
Setup in Autoscaling Group of 1 to give HA if the hardware side fails or AZ then will spin up new one in another AZ.
Setup by Chef Cookbook utilizing Chef Zero. Pulling the Cookbook from this repo as needed.
DNS Script setup to update Route53 Internal DNS when new one spins up.

# Prerequisites
* VPC with Public and Private subnets
* Git LFS installed if running from clone locally

# Default Allowed Access
1. AWS Service APIs (i.e. CFN Init, ECS, SNS, SES)
2. AWS Linux Package Repos
3. *.rubygems.org
4. *.wordpress.org, *.wordpress.com (Wordpress Updates)
5. docs.google.com (Temp) for Sheets access (Wordpress Plugin)

# Launcher
Click this button to open AWS CloudFormation web console to enter parameters and create the stack.<br>
[![Squid Proxy](https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?#/stacks/new?&templateURL=https://s3.amazonaws.com/bonusbits-public/cloudformation-templates/cookbooks/awsapi-squid-proxy.yml)


# CloudFormation Template Details
The [CloudFormation Template](https://github.com/bonusbits/bonusbits_awsapi_proxy/blob/master/aws/awsapi-access-proxy-template.yml) does the following:

1. Create EC2 Instance using EBS volume
    1. t2.nano (default)
2. Autoscaling Group of 1 for DR
3. Setup CloudWatch Logs for Proxy Instance
4. Create Proxy Access Security Group
5. Installs some basic packages needed for bootstrapping
    1. cfn-init
    2. aws-cfn-bootstrap
    3. cloud-init
6. Add DNS Update Script to Userdata   
6. Setup and Execute Chef Zero
    1. Install Chef Client from internet
    2. Create Chef Configuration Files
    2. Download bonusbits_awsapi_proxy cookbook from Github
    3. Triggers Chef Zero run

# Cookbook
1. Installs Squid 3.5.11
2. Add AWS API Access configurations
3. Starts Squid
4. Install and configure CloudWatch Logs Agent
5. Setup scripts and cron jobs to stream logs to CloudWatch Logs

# Tips
1. If needed the instance size can be increased.
2. Optionally you could add an ELB and scale past one, but I designed it to be an affordable easy solution. 