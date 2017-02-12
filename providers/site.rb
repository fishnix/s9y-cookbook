#
# Cookbook Name:: s9y-cookbook
# Provider:: s9y_site
#
# Copyright (C) 2014 E Camden Fisher
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

include Chef::DSL::IncludeRecipe

def whyrun_supported?
  true
end

use_inline_resources

action :create do
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"

  install_package_dependencies
  prepare_base_directory
  create_shared_dir  unless ::File.exist?("#{site_directory}/shared/")
  generate_config_local unless ::File.exist?("#{site_directory}/shared/serendipity_config_local.php")
  create_uploads_dir unless ::File.exist?("#{site_directory}/shared/uploads")
  create_archive_dir unless ::File.exist?("#{site_directory}/shared/archive")
  create_templates_dir unless ::File.exist?("#{site_directory}/shared/templates")
  create_plugins_dir unless ::File.exist?("#{site_directory}/shared/plugins")
  deploy_framework unless ::File.exist?("#{site_directory}/current")
  manage_custom_plugins
  manage_custom_templates
  apache_web_app unless ::File.exists?("/etc/httpd/sites-available/#{site_name}.conf")
end

action :update do
  install_package_dependencies
  prepare_base_directory
  create_shared_dir
  generate_config_local
  create_uploads_dir
  create_archive_dir
  create_templates_dir
  create_plugins_dir
  deploy_framework
  manage_custom_plugins
  manage_custom_templates
  apache_web_app
end

private

def prepare_base_directory
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"

  unless ::File.directory?(base_directory)
    Chef::Log.info "Creating s9y site base directory: #{base_directory}"
    a = directory base_directory do
      recursive true
      owner 'root'
      group 'root'
      mode 0755
      action :create
    end
    new_resource.updated_by_last_action(a.updated_by_last_action?)
  end

  unless ::File.directory?(site_directory)
    Chef::Log.info "Creating s9y site base directory: #{site_directory}"
    a = directory site_directory do
      recursive true
      owner 'root'
      group 'apache'
      mode 0775
      action :create
    end
    new_resource.updated_by_last_action(a.updated_by_last_action?)
  end
end

def install_package_dependencies
  package "ImageMagick" do
    package_name "ImageMagick"
    action :install
  end
end

def create_shared_dir
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"

  directory "#{site_directory}/shared" do
    mode '0755'
    owner 'root'
    group 'apache'
    action :create
  end
end

def create_uploads_dir
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"

  directory "#{site_directory}/shared/uploads" do
    mode '0777'
    owner 'apache'
    group 'apache'
    action :create
  end
end

def create_archive_dir
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"

  directory "#{site_directory}/shared/archive" do
    mode '0777'
    owner 'apache'
    group 'apache'
    action :create
  end
end

def create_templates_dir
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"

  directory "#{site_directory}/shared/templates" do
    mode '0755'
    owner 'root'
    group 'apache'
    action :create
  end

  directory "#{site_directory}/shared/templates_c" do
    mode '0777'
    owner 'apache'
    group 'apache'
    action :create
  end
end

def create_plugins_dir
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"

  directory "#{site_directory}/shared/plugins" do
    mode '0777'
    owner 'apache'
    group 'apache'
    action :create
  end
end

def generate_config_local
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"

  t = template "#{site_directory}/shared/serendipity_config_local.inc.php" do
    source 'serendipity_config_local.inc.php.erb'
    cookbook new_resource.cookbook
    owner 'apache'
    group 'apache'
    mode 0660
    backup false
    variables(
        :version       => new_resource.version,
        :db_name       => new_resource.database['name'],
        :db_user       => new_resource.database['user'],
        :db_prefix     => new_resource.database['prefix'],
        :db_host       => "#{new_resource.database['host']}:#{new_resource.database['port']}",
        :db_pass       => new_resource.database['password'],
        :db_type       => new_resource.database['type'],
        :db_persistent => new_resource.database['persistent'],
        :db_charset    => new_resource.database['charset']
    )
  end
  new_resource.updated_by_last_action(t.updated_by_last_action?)
end

def deploy_framework
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"

  symlinks = {
    '.htaccess' => '.htaccess',
    'serendipity_config_local.inc.php' => 'serendipity_config_local.inc.php',
    'templates_c' => 'templates_c',
    'uploads' => 'uploads',
    'plugins' => 'plugins',
    'archives' => 'archives',
    'favicon.ico' => 'favicon.ico'
  }

  new_resource.custom_templates.each do |t|
    dir = "templates/#{t['name']}"
    symlinks[dir] = dir
  end

  new_resource.custom_plugins.each do |p|
    dir = "plugins/#{p['name']}"
    symlinks[dir] = dir
  end

  deploy_revision site_directory do
    repo new_resource.git_repo
    branch new_resource.git_branch
    symlink_before_migrate.clear
    create_dirs_before_symlink.clear
    purge_before_symlink %w{ templates_c uploads plugins }
    symlinks(symlinks)
    user 'root'
    group 'apache'
    enable_submodules false
    migrate false
    shallow_clone true
    action :deploy
  end
end

def manage_custom_plugins
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"
  custom_plugins = new_resource.custom_plugins

  custom_plugins.each do |cp|
    git "#{site_directory}/shared/plugins/#{cp['name']}" do
      repository cp['repo']
      reference cp['branch'] || 'master'
      action :sync
    end
  end
end

def manage_custom_templates
  base_directory = new_resource.basedir
  site_name = new_resource.name
  site_directory = "#{base_directory}/#{site_name}"
  custom_templates = new_resource.custom_templates

  custom_templates.each do |ct|
    git "#{site_directory}/shared/templates/#{ct['name']}" do
      repository ct['repo']
      reference ct['branch'] || 'master'
      action :sync
    end
  end
end

def apache_web_app
  base_directory = new_resource.basedir
  site_name = new_resource.name
  aliases = new_resource.aliases
  site_directory = "#{base_directory}/#{site_name}"
  params = {
      :server_name => site_name,
      :server_aliases => aliases,
      :docroot =>  "#{site_directory}/current",
      :allow_override => 'All'
  }

  include_recipe 'apache2::default'
  include_recipe 'apache2::mod_rewrite'
  include_recipe 'apache2::mod_deflate'
  include_recipe 'apache2::mod_headers'


  service 'apache2' do
    service_name 'httpd'
    reload_command '/sbin/service httpd graceful'
    supports [:start, :restart, :reload, :status]
    action [:enable, :start]
    only_if "#{node['apache']['binary']} -t", :environment => { 'APACHE_LOG_DIR' => node['apache']['log_dir'] }, :timeout => 10
  end

  template "/etc/httpd/sites-available/#{site_name}.conf" do
    source "web_app.conf.erb"
    owner 'root'
    group 'root'
    mode '0644'
    cookbook "s9y"
    variables(
        :application_name => site_name,
        :params           => params
    )
    if ::File.exist?("/etc/httpd/sites-enabled/#{site_name}.conf")
      notifies :reload, 'service[apache2]', :delayed
    end
  end

  apache_site site_name do
    enable true
  end
end
