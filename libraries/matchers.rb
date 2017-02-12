if defined?(ChefSpec)
  def create_s9y_site(site)
    ChefSpec::Matchers::ResourceMatcher.new(:s9y_site, :create, site)
  end

  def update_s9y_site(site)
    ChefSpec::Matchers::ResourceMatcher.new(:s9y_site, :update, site)
  end
end
