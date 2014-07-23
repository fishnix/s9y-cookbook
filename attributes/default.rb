#
# default s9y attributes
#
default[:s9y][:git_repo] = 'git://github.com/s9y/Serendipity.git'

default[:s9y][:deploy_branch]	= "1.7"
default[:s9y][:base_dir]	    = "/var/www/vhost"
default[:s9y][:version]		    = "1.7"
default[:s9y][:dbName]		    = "serendipity"
default[:s9y][:dbPrefix]	    = "serendipity_"
default[:s9y][:dbHost]		    = "localhost"
default[:s9y][:dbUser]		    = "serendipity"
default[:s9y][:dbPass]		    = "serendipity"
default[:s9y][:dbType]		    = "mysql"
default[:s9y][:dbPersistent]	= "false"
default[:s9y][:dbCharset]	    = "utf8"

# set default empty site list
default[:s9y][:sites]         = [ ]

# don't bootstrap DB by default
default[:s9y][:bootstrap_db] = false

# redirect admin to https
default[:s9y][:redirect_admin] = true

# redirect mydomain.com to www.mydomain.com?
default[:s9y][:redirect_domain] = true	

default[:s9y][:default_schema_url] = nil