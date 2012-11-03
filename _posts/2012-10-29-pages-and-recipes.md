---
layout: static
title: Pages and Recipes
summary: Explaining how Pages and Recipes work
tags: Tutorials
---
# Pages and Recipes

## Creating your first page type

ActiveAdmin CMS requires you to define at least one type of page to use with the cms.  This consists of a model to represent the type of page.  The easiest way to create a new model is to use the generator.

{% highlight bash %}
> rails g active_admin:cms:page Page
{% endhighlight %}

This will create a new model, a migration to add the database table, add the ActiveAdmin definitions and create the views for editing the page.

You will need to run the migration using rake db:migrate.  You should now have a pages tab in active admin.  However if you try and create a page, you will probably get a validation error saying that recipe is a mandatory field.  So now we need to create a recipe.

## Creating a recipe

Recipes represent the structure of the content to be stored in the CMS.  It is essentialy a model and so recipes live in your app/models/recipes/ folder.

A typical recipe might look something like this:

{% highlight ruby %}
module Recipes
  class Default < Cms::Recipe
    
    define do
      section :main_content do
        image :title_image, :hint => 'An image containing the title of the page'
        string :sub_heading, :hint => 'The text that appears in bold under the title'
        text :content, :hint => 'The main copy for the page'
      end

      section :side_bar do
        image :image_1
        image :image_2
      end
    end

  end
end
{% endhighlight %}

So we are saying that pages using this recipe should have 2 sections of content.  In the main content area, there should be a title image, a short sub-heading and then a chunk of text which is the main copy for the page.  There is also a side bar that contaings 2 images.

There is a generator to create a new recipe as well

{% highlight bash %}
> rails g active_admin:cms:recipe MyNewRecipe
{% endhighlight %}

This will create a new recipe at app/models/recipes/my_new_recipe.rb

## Customising the recipe

As you can see from the example above, recipes are split into sections.  Within each section, you can have multiple content items.  The content items defined by default are

image : An image
string : A short piece of text (represented by an &lt;input type="text"&gt;)
text : A larger piece of text possibly split into multiple paragraphs.  This type supports markdown formatting by default
text_and_image : An image with an associated piece of text

These content types can be customised to suit your requirements.  You can also add new content types if you need them.  For more information on customising content types please see ...