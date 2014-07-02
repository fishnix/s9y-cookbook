require 'spec_helper'

describe file('/etc/httpd/conf.d/test.kitchen.ci.conf') do
  it { should be_file }
  its(:content) { should match /ServerName test.kitchen.ci/ }
end

describe file('/var/www/vhost/test.kitchen.ci') do
  it { should be_directory }
end

describe file('/var/www/vhost/test.kitchen.ci/serendipity_config_local.inc.php') do
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'apache' }
  its(:content) { should match /\$serendipity\['dbName'\].*=.*'test_kitchen_ci'\;$/ }
end