# Description

Installs and configures the [S9Y blogging platform](http://www.s9y.org).

### Notes:
* I've only ever tested this with mysql
* I have not switched to the community apache2, mysql or php5 cookbooks.  This will probably not break
    this cookbook, but I haven't tested it yet.


# Supported Platforms

CentOS 5.x/6.x

# Requirements

## Cookbooks:
* apache2
* php5
* git
* mysql
* database
 
## Databags

For eache site enumerated in the `node[:s9y][:sites]` attribute, you require a databag with the site_name set to that name.

#### for example...
    node[:s9y][:sites] = ["test.example.com"]

#### requires: data_bags/s9y_sites/test.example.com.json:
    {
      "id": "test_example_com",
      "site_name": "test.example.com",
      "version": "1.7",
      "dbName": "test_example_com",
      "dbPrefix": "serendipity_",
      "dbHost": "127.0.0.1",
      "dbUser": "testdbUser",
      "dbPass": "changeme",
      "dbType": "mysql",
      "dbPersistent": "false",
      "dbCharset": "utf8",
      "site_aliases": [ ],
      "deploy_branch": "",
      "git_repo": "",
      "custom_tmpl": { "awesometemplate":"git://github.com/user/awesometemplate.git" },
      "custom_plgn": { 
          "awesomeplugin":"git://github.com/user/awesomeplugin.git",
          "lameplugin":"git://github.com/user/lameplugin.git"
        }
    }

*Note*: if you don't have a data bag in place, it _should_ function with defaults for testing.

# Attributes

#### default attributes that can be overridden by the data bag
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

#### set default empty site list
    default[:s9y][:sites]         = [ ]

#### don't bootstrap DB by default
    default[:s9y][:bootstrap_db] = false

#### redirects admin to https
    default[:s9y][:redirect_admin] = true

#### redirects mydomain.com to www.mydomain.com
    default[:s9y][:redirect_domain] = true


# Usage

## Recipes

#### s9y::default

Include `s9y` in your node's `run_list` to get:

* `s9y::prep`
* `s9y::framework`
* `s9y::plugins`
* `s9y::templates`
* `s9y::apache2`
* `s9y::db`
 
#### s9y::prep

Install's package dependencies and preps the filesystem for s9y.

#### s9y::framework

Pulls the framework from git, creates required subdirs and builds the local config file.

#### s9y::plugins

Installs custom plugins from git locations.  *Note:* This does _not_ enable them.

#### s9y::templates

Installs custom templates from git locations.

#### s9y::apache2

Configures apache VirtualHosts for each site.

####s9y::db

Ensures the database and db user are created and the password is known by chef.

# Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

# License and Authors

Author:: E Camden Fisher (<fish@fishnix.net>)

