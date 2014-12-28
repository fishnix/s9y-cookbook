#
# Cookbook Name:: s9y
# Recipe:: default
#
# Copyright (C) 2015 E Camden Fisher
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 's9y::_packages'
include_recipe 's9y::_php'

db = node['s9y']['data_bag']
dbi = node['s9y']['data_bag_item']
site = Chef::EncryptedDataBagItem.load(db, dbi)

s9y_site site['site_name'] do
  basedir           node['s9y']['basedir']
  owner             node['s9y']['owner']
  group             node['s9y']['group']
  manage_database   node['s9y']['manage_database']
  aliases           site['site_aliases']
  version           site['version']
  git_repo          site['git_repo']
  git_branch        site['git_branch']
  custom_templates  site['custom_templates']
  custom_plugins    site['custom_plugins']
  database          site['database']
end
