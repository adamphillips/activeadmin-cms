---
layout: static
title: Getting started
summary: Installing and configuring ActiveAdmin CMS
tags: Tutorials
---
# Getting Started

First you need to add ActiveAdmin Cms to your gemfile and run a bundle install

{% highlight ruby %}
# Gemfile
gem 'activeadmin-cms'
{% endhighlight %}

{% highlight bash %}
> bundle install
{% endhighlight %}

### Run active admin install

If you haven't already run the ActiveAdmin install generator, do this first.

{% highlight bash %}
> rails g active_admin:install
{% endhighlight %}

Follow the on-screen instructions.

The default user has a login of 'admin@example.com' and a password of 'password'.

### Run CMS install

{% highlight bash %}
> rails g active_admin:cms:install
{% endhighlight %}

### Configure Fog

Create a new file in config/initializers called fog.rb to setup fog.

{% highlight ruby %}
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
{% endhighlight %}

### Generate a page class

{% highlight bash %}
> rails g active_admin:cms:page Page
{% endhighlight %}

### Generate a recipe

{% highlight bash %}
> rails g active_admin:cms:recipe Default
{% endhighlight %}

You will need to also create a migration to insert a database record for the recipe

{% highlight bash %}
> rails g migration AddDefaultRecipe
{% endhighlight %}

{% highlight ruby %}
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
{% endhighlight %}
