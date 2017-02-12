require 'spec_helper'

describe package('ImageMagick') do
  it { should be_installed }
end

describe file('/var/www/vhost/test.kitchen.ci') do
  it { should be_directory }
end

describe file('/var/www/vhost/test.kitchen.ci/releases') do
  it { should be_directory }
end

describe file('/var/www/vhost/test.kitchen.ci/shared') do
  it { should be_directory }
end

describe file('/var/www/vhost/test.kitchen.ci/current') do
  it { should be_symlink }
end

describe file('/var/www/vhost/test.kitchen.ci/shared/serendipity_config_local.inc.php') do
  it { should be_file }
  it { should be_mode 660 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'apache' }
  its(:content) { should match /\$serendipity\['dbName'\].*=.*'test_kitchen_ci'\;$/ }
end
