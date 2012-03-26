require "generator_spec/test_case"
require 'generators/active_admin/cms/recipe/recipe_generator'

describe ActiveAdmin::Cms::RecipeGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(TestRecipe)

  before(:all) do
    prepare_destination
    run_generator
  end

  specify do
    destination_root.should have_structure {
      no_file "test.rb"
      directory "app" do
        directory "models" do
          directory "recipes" do
            file "test_recipe.rb" do
              contains "TestRecipe < ActiveAdmin::Cms::Recipe"
            end
          end
        end
      end
    }
    #ActiveAdmin::Cms::Recipe.last.type.should == 'Recipes::TestRecipe'
    #"Recipes::#{class_name}".class.count.should == 1
    #"Recipes::#{class_name}".class.last.title.should == 'Test Recipe'
  end

end


