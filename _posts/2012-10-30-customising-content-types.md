---
layout: static
title: Customising Content Types
summary: How to update the existing content types and create new ones
tags: Tutorials
---
# Customising Content Types

## Customising the existing Content Types

It is highly likely that you will want to customise the content types that come with ActiveAdmin CMS.  For example, the default sizes of images created by the image content type are 55px wide and 155px wide.  The chances that these are the exact sizes needed for your website are pretty small so let's start by looking at how we would go about changing them

ActiveAdmin CMS uses the Carrierwave gem to handle uploads.  Carrierwave works by using Uploader classes that specify the details of the file to be uploaded.  By default, ActiveAdmin CMS images use the ActiveAdmin::Cms::Uploaders::ContentImageUploader.  The easiest way to change the uploader settings is probably to define a new uploader and then set the image content type to use that.

Fortunately Carrierwave has it's own generator for creating these classes so at the console you just need to type

{% highlight bash %}
rails g uploader MyNewImageUploader
{% endhighlight %}

There are lots of options that you can use to control what happens to your uploaded files and I suggest you check out the Carrierwave docs for more information.  One key point to note however is that by default, ActiveAdmin CMS uses the Fog gem to store the images on Amazon S3.  If you want to continue using this with your new Uploader, be sure to include the line

{% highlight ruby %}
storage :fog
{% endhighlight %}

Once you have setup your new uploader, we just need to tell the image content type to use this uploader instead of the default.

So to do this, we need to override the image_uploader method of the ActiveAdmin::Cms::ContentTypes::Image class to return our new uploader instead of the default one.  To do this, in an initializer we just need to include the following:

{% highlight ruby %}
class ActiveAdmin::Cms::ContentTypes::Image
  def self.image_uploader
    MyNewImageUploader
  end
end
{% endhighlight %}
