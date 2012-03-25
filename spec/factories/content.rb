# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content, :class => ActiveAdmin::Cms::Content do
  end

  factory :image_content, :class => ActiveAdmin::Cms::Content do
    content_type ActiveAdmin::Cms::ContentTypes::Image
  end

  factory :text_content, :class => ActiveAdmin::Cms::Content do
    content_type ActiveAdmin::Cms::ContentTypes::Text
  end
end

