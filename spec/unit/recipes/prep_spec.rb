require 'spec_helper'

describe 's9y::prep' do

	platforms = {
    'centos' => ['6.5'],
  }

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

  platforms.each do |platform, versions|
  	versions.each do |version|

	  	context "on #{platform.capitalize} #{version}" do
			  let (:chef_run) do
			  	ChefSpec::Runner.new(log_level: :warn, platform: platform, version: version) do |node|
						node.set['apache2']['dir'] = '/etc/httpd'
						node.set['apache2']['namevhosts'] = ['first.site.test:80']
						node.set['s9y']['sites'] = ['first_site_test']
			  	end.converge(described_recipe) 
			  end
			  
			  it 'installs the ImageMagick package' do
			    chef_run.should install_package('ImageMagick')
			  end
			  
			  it 'creates s9y base directory owned by root/apache' do
			    expect(chef_run).to create_directory('/var/www/vhost').with(
			  		user: 'root',
			  		group: 'apache'
			    )
			  end
			end
		end
	end
end
  
  