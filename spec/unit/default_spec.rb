require 'spec_helper'


describe 's9y::default' do

  platforms = {
      'centos' => ['6.6']
  }

  platforms.each do |platform, versions|
    versions.each do |version|

      context "on #{platform.capitalize} #{version}" do
        let (:chef_run) do
          ChefSpec::Runner.new(log_level: :warn, platform: platform, version: version) do |node|
            # set additional node attributes here
          end.converge(described_recipe)
        end

        it 'should include the s9y::_packages recipe by default' do
          expect(chef_run).to include_recipe 's9y::_packages'
        end

        it 'should include the s9y::_php recipe by default' do
          expect(chef_run).to include_recipe 's9y::_php'
        end

        it 'should create the s9y_site www.example.com' do
          expect(chef_run).to create_s9y_site('www.example.com')
        end
      end
    end
  end
end
