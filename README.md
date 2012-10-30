# ActiveAdmin Cms

[![Build Status](https://secure.travis-ci.org/adamphillips/activeadmin-cms.png)](http://travis-ci.org/adamphillips/activeadmin-cms)

[![Build Status](https://codeclimate.com/badge.png)](https://codeclimate.com/github/adamphillips/activeadmin-cms)

A simple CMS extension for ActiveAdmin.

## Getting Started


First you need to add ActiveAdmin Cms to your gemfile and run a bundle install
`
  # Gemfile
  gem 'activeadmin-cms'

  # On command line
  > bundle install
`

### Run active admin install

  If you haven't already run the ActiveAdmin install generator, do this first.
`
  > rails g active_admin:install
`
Follow the on-screen instructions.

The default user has a login of 'admin@example.com' and a password of 'password'.

### Run CMS install

  > rails g active_admin:cms:install

### Configure Fog

Create a new file in config/initializers called fog.rb to setup fog.
`
  # config/initializers/fog.rb
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => '-aws-access-key-',
      :aws_secret_access_key  => '-aws-secret-,
      :region => 'eu-west-1'
    }
    config.fog_host  = "//mywebsite.co.uk.s3.amazonaws.com"
    config.fog_directory  = "mywebsite.co.uk"
  end
`
### Generate a page class
`
  > rails g active_admin:cms:page Page
`
### Generate a recipe
`
  > rails g active_admin:cms:recipe Default
`
You will need to also create a migration to insert a database record for the recipe
`
  > rails g migration AddDefaultRecipe

  # db/migrations/123456789_add_default_recipe.rb
  class AddDefaultRecipe < ActiveRecord::Migration
    def up
      r = Recipes::Default.new
      r.title = 'Default'
      r.type = 'Recipes::Default'
      r.save
    end

    def down
    end
  end
`