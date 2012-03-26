# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content, :class => ActiveAdmin::Cms::Content do
  end

  factory :image_content, :class => ActiveAdmin::Cms::Content do
    content_type_class 'ActiveAdmin::Cms::ContentTypes::Image'
    content_type ActiveAdmin::Cms::ContentTypes::Image
  end

  factory :large_image_content, :class => ActiveAdmin::Cms::Content do
    content_type_class 'ActiveAdmin::Cms::ContentTypes::LargeImage'
    content_type ActiveAdmin::Cms::ContentTypes::LargeImage
  end

  factory :text_content, :class => ActiveAdmin::Cms::Content do
    content_type_class 'ActiveAdmin::Cms::ContentTypes::Text'
    content_type ActiveAdmin::Cms::ContentTypes::Text
  end
end

