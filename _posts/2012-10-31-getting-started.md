---
layout: static
title: Getting started
summary: Installing and configuring ActiveAdmin CMS
tags: Tutorials
---
# Getting Started

First you need to add ActiveAdmin Cms to your gemfile and run a bundle install

<pre class="brush: ruby; gutter: false">
# Gemfile
gem 'activeadmin-cms'
</pre>

<pre class="brush: bash; gutter: false">
> bundle install
</pre>

### Run active admin install

If you haven't already run the ActiveAdmin install generator, do this first.

<pre class="brush: bash; gutter: false">
> rails g active_admin:install
</pre>

Follow the on-screen instructions.

The default user has a login of 'admin@example.com' and a password of 'password'.

### Run CMS install

<pre class="brush: bash; gutter: false">
> rails g active_admin:cms:install
</pre>
Configure Fog

Create a new file in config/initializers called fog.rb to setup fog.

<pre class="brush: ruby; gutter: false">
# config/initializers/fog.rb
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => '-aws-access-key-',
    :aws_secret_access_key  => '-aws-secret-',
    :region => 'eu-west-1'
  }
  config.fog_host  = "//mywebsite.co.uk.s3.amazonaws.com"
  config.fog_directory  = "mywebsite.co.uk"
end
</pre>

### Generate a page class

<pre class="brush: bash; gutter: false">
> rails g active_admin:cms:page Page
</pre>

### Generate a recipe

<pre class="brush: bash; gutter: false">
> rails g active_admin:cms:recipe Default
</pre>

You will need to also create a migration to insert a database record for the recipe

<pre class="brush: bash; gutter: false">
> rails g migration AddDefaultRecipe
</pre>

<pre class="brush: ruby; gutter: false">
# db/migrations/123456789_add_default_recipe.rb
class AddDefaultRecipe &gt; ActiveRecord::Migration
  def up
    r = Recipes::Default.new
    r.title = 'Default'
    r.type = 'Recipes::Default'
    r.save
  end

  def down
  end
end
</pre>