#
# Cookbook Name:: s9y
# Recipe:: templates
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
# Installs custom templates

# get the list of sites from the node attributes
s9y_sites = node[:s9y][:sites]

# Loop over each site's data_bag
s9y_sites.each do |s9y_site|

  site_defs = data_bag_item('s9y_sites', s9y_site)
  site_name      = site_defs['site_name']

  # Pull custom templates from git
  site_defs['custom_tmpl'].each do |ct|
    git "#{node[:s9y][:base_dir]}/#{site_name}/templates/#{ct[0]}" do
      repository ct[1]
      reference "master"
      action :sync
    end
  end

end