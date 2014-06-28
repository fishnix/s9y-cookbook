#
# Cookbook Name:: s9y
# Recipe:: framework
#
# sets up the s9y frameowork, including code, directories + config
#
# Copyright 2011, E Camden Fisher
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "s9y::prep"

# get the list of sites from the node attributes
s9y_sites = node[:s9y][:sites]

# Loop over each site's data_bag
s9y_sites.each do |s9y_site|

  site_defs = data_bag_item('s9y_sites', s9y_site)
  site_name      = site_defs['site_name']
  version        = site_defs['version']      || node[:s9y][:version]
  db_name        = site_defs['dbName']       || node[:s9y][:dbName]
  db_user        = site_defs['dbUser']       || node[:s9y][:dbUser]
  db_prefix      = site_defs['dbPrefix']     || node[:s9y][:dbPrefix]
  db_host        = site_defs['dbHost']       || node[:s9y][:dbHost]
  db_pass        = site_defs['dbPass']       || node[:s9y][:dbPass]
  db_type        = site_defs['dbType']       || node[:s9y][:dbType]
  db_persistent  = site_defs['dbPersistent'] || node[:s9y][:dbPersistent]
  db_charset     = site_defs['dbCharset']    || node[:s9y][:dbCharset]
  deploy_branch  = site_defs['deploy_branch'] || node[:s9y][:deploy_branch]
  git_repo       = site_defs['git_repo']      || node[:s9y][:git_repo]

  # Pull s9y from repo in git
  git "#{node[:s9y][:base_dir]}/#{site_name}" do
    repository git_repo
    reference "master"
    branch deploy_branch
    action :sync
  end
  
  directory "#{node[:s9y][:base_dir]}/#{site_name}" do
     mode 0775
     owner "root"
     group node[:apache2][:user]
     action :create
  end
  
  %w{ uploads templates_c plugins }.each do |dir|
    directory "#{node[:s9y][:base_dir]}/#{site_name}/#{dir}" do
       mode 0775
       owner "root"
       group node[:apache2][:user]
       action :create
    end
  end
  
  directory "#{node[:s9y][:base_dir]}/#{site_name}/templates" do
     mode 0755
     owner "root"
     group "root"
     action :create
  end

  template "#{node[:s9y][:base_dir]}/#{site_name}/serendipity_config_local.inc.php" do
    source "serendipity_config_local.inc.php.erb"
    owner "root"
    group node[:apache2][:user]
    mode 0660
    backup false
    variables(
      :version       => version,
      :db_name       => db_name,
      :db_user       => db_user,
      :db_prefix     => db_prefix,
      :db_host       => db_host,
      :db_pass       => db_pass,
      :db_type       => db_type,
      :db_persistent => db_persistent,
      :db_charset    => db_charset  
    )
  end
end