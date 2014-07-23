require 'spec_helper'

describe 's9y::php' do

  platforms = {
      'centos' => { 
        'versions' => ['6.5'],
        'packages' => ["php-Smarty", "php-pecl-apc", "php-gd", "php-mysql", "php-xml", "php-pecl-memcache"]
      },
      'ubuntu' => { 
        'versions' => ['12.04'],
        'packages' => ["php-Smarty", "php5-apc", "php5-gd", "php5-mysql", "php5-xml", "php5-memcache"]
      },
    }
  

  # platforms = {
  #     'centos' => ['6.5'],
  #   }

	before(:each) do
		ChefSpec::Server.create_data_bag('s9y_sites', {
				'first_site_test' => {
					id: 'first_site_test',
					site_name: 'first.site.test',
					version: "1.7",
					dbName: "first_site_test",
					dbPrefix: "serendipity_",
					dbHost: "localhost",
					dbUser: "dbuser",
					dbPass: "dbpass",
					dbType: "mysql",
					dbPersistent: "false",
					dbCharset: "utf8",
					site_aliases: [ ],
					custom_tmpl: { },
					custom_plgn: { }
				}
			})
      
	end

  platforms.each do |name, platform|
  	platform['versions'].each do |version|
	  	context "on #{name.capitalize} #{version}" do
			  let (:chef_run) do
			  	ChefSpec::Runner.new(log_level: :warn, platform: name, version: version) do |node|
						node.set['apache2']['dir'] = '/etc/httpd'
						node.set['apache2']['namevhosts'] = ['first.site.test:80']
						node.set['s9y']['sites'] = ['first_site_test']
			  	end.converge(described_recipe) 
			  end
        
			  it 'should include the php recipe by default' do
			    chef_run.should include_recipe 'php::default'
			  end
        
        platform['packages'].each do |p|
          it "should install platform specific php package #{p}" do
            chef_run.should install_package(p)
          end
        end
			end
		end
	end
end
  
  