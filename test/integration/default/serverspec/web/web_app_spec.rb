require 'spec_helper'

describe package('httpd') do
  it { should be_installed }
end

describe service('httpd') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(80) do
  it { should be_listening }
end

describe file('/etc/httpd/sites-available/test.kitchen.ci.conf') do
  it { should be_file }
  its(:content) { should match /ServerName test.kitchen.ci/ }
end

describe file('/etc/httpd/sites-enabled/test.kitchen.ci.conf') do
  it { should be_symlink }
end
