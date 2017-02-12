# s9y-cookbook

An application cookbook for configuring S9Y sites

## Supported Platforms

CentOS 6.x

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>node['s9y']['basedir']</tt></td>
    <td>String</td>
    <td>Base directory for s9y installs</td>
    <td><tt>/var/www/vhost</tt></td>
  </tr>
  <tr>
    <td><tt>node['s9y']['owner']</tt></td>
    <td>String</td>
    <td>Owner for s9y dirs</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>node['s9y']['group']</tt></td>
    <td>String</td>
    <td>Group for s9y dirs</td>
    <td><tt>/var/www/vhost</tt></td>
  </tr>
  <tr>
    <td><tt>node['s9y']['manage_database']</tt></td>
    <td>String</td>
    <td>Should we manage the database?</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>node['s9y']['data_bag']</tt></td>
    <td>String</td>
    <td>What data bag should we look in for sites?</td>
    <td><tt>s9y_sites</tt></td>
  </tr>
  <tr>
    <td><tt>node['s9y']['data_bag_item']</tt></td>
    <td>String</td>
    <td>What data bag item should we use?</td>
    <td><tt>www.example.com</tt></td>
  </tr>
</table>

## Usage

You can use this cookbook for a _single_ site by:
 - creating a data bag s9y_sites
 - creating an encrypted data bag item for your site
 - setting (at least) the `node['s9y']['data_bag_item']` attribute
 - including the `s9y::default` recipe in your node's `run_list`

Alternatively you can use the provides `s9y_site` LWRP...

## LWRP

### s9y_site

```ruby
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
```

## Recipes

### s9y::default

Include `s9y` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[s9y::default]"
  ]
}
```

## License and Authors

Author:: E Camden Fisher (<fish@fishnix.net>)
