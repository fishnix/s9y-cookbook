require 'spec_helper'

describe 's9y::default' do
  let (:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.5').converge('s9y::default') }
    
  it 'should include the apache2 recipe by default' do
    chef_run.should include_recipe 's9y::apache2'
  end
  
  it 'should include the db recipe by default' do
    chef_run.should include_recipe 's9y::db'
  end
  
  it 'should include the framework recipe by default' do  
    chef_run.should include_recipe 's9y::framework'
  end
  
  it 'should include the plugins recipe by default' do
    chef_run.should include_recipe 's9y::plugins'
  end
  
  it 'should include the prep recipe by default' do
    chef_run.should include_recipe 's9y::prep'
  end
  
  it 'should include the templates recipe by default' do
    chef_run.should include_recipe 's9y::templates'
  end
  
end