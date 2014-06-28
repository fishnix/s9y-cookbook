#
# Cookbook Name:: s9y
# Recipe:: apache2
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
# Configures apache2 for use with s9y sites

include_recipe "apache2"

# get the list of sites from the node attributes
s9y_sites = node[:s9y][:sites]

# Loop over each site's data_bag
s9y_sites.each do |s9y_site|

  site_defs = data_bag_item('s9y_sites', s9y_site)
  site_name = site_defs['site_name']

  # Setup site aliases in apache config
  site_aliases = site_defs['site_aliases']
  
  if node[:s9y][:redirect_domain] and site_name.start_with?("www")
    domain = site_name.sub /^www\./, ''
  else
    domain = nil
  end

  # Write apache config
  template "#{node[:apache2][:dir]}/conf.d/#{site_name}.conf" do
    source "s9y_apache_conf.erb"
    owner "root"
    group "root"
    mode 0644
    variables({
      :docroot => "#{node[:s9y][:base_dir]}/#{site_name}",
      :server_name => site_name,
      :server_aliases => site_aliases,
      :domain_name => domain,
    })
    notifies :restart, "service[apache2]"
  end
end
