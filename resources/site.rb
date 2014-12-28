actions :create, :update
default_action :create

attribute :name,              :kind_of => String, :name_attribute => true
attribute :aliases,           :kind_of => Array, :default => []
attribute :basedir,           :kind_of => String, :default => '/var/www/vhost'
attribute :version,           :kind_of => String, :default => '1.7.8'
attribute :git_repo,          :kind_of => String, :default => 'git://github.com/s9y/Serendipity.git'
attribute :git_branch,        :kind_of => String, :default => '1.7.8'
attribute :owner,             :kind_of => String, :default => 'root'
attribute :group,             :kind_of => String, :default => 'apache'
attribute :custom_templates,  :kind_of => Array, :default => []
attribute :custom_plugins,    :kind_of => Array, :default => []
attribute :database,          :kind_of => Hash, :default => { 'type' => 'mysql',
                                                              'name' => 's9y',
                                                              'prefix' => 'serendipity_',
                                                              'user' => 's9y',
                                                              'password' => 's9y',
                                                              'host' => 'localhost',
                                                              'port' => '3306',
                                                              'persistent' => 'false',
                                                              'charset' => 'utf8'}
attribute :manage_database,   :kind_of => [TrueClass, FalseClass], :default => false
attribute :cookbook,          :kind_of => String, :default => 's9y'
