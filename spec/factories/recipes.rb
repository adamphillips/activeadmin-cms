# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe, :class => ActiveAdmin::Cms::Recipe do
  end

  factory :basic_recipe, :class => ActiveAdmin::Cms::Recipe do |recipe|
    title "Basic Recipe"
    after(:build) do |r|
      r.section :column do
        text :text_ingredient_1
        image :image_ingredient_1
      end
      r.section :footer do
        text :address
      end
    end
  end
end

