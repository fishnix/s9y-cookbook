require 'spec_helper'

describe 's9y::apache2' do

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
			  
			  it 'should include the apache2 recipe by default' do
			    chef_run.should include_recipe 'apache2::default'
			  end
			  
			  it 'creates the sites http config' do
			    expect(chef_run).to render_file('/etc/httpd/conf.d/first.site.test.conf')
			  end
			end
		end
	end
end
  
  