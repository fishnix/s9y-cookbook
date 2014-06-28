#
# Cookbook Name:: s9y
# Recipe:: db
#
# Sets up database if one doesn't exist
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
   
  mysql_connection_info = {:host => db_host, :username => 'root', :password => node[:mysql][:server_root_password]}
  
  # create the database
  mysql_database db_name do
    connection mysql_connection_info
    action :create
  end
    
  # create the user, grant all privelages on db
  mysql_database_user db_user do
    connection mysql_connection_info
    password db_pass
    database_name db_name
    action [:create, :grant]
  end
   
end