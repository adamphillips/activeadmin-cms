module Recipes
  class Default < ActiveAdmin::Cms::Recipe
   
    define do 
 
      # Here is where you layout the admin fields for your recipe
      #
      # For example
      #
      # section :column_1 do
      #   string :heading, :hint => 'The 1st column heading'
      #   text :content, :hint => 'The rest of the content
      #   image :picture
      # end

      section :main do
        image :heading_image
        text :content, :hint => 'The main content in the centre of the page'
      end

    end
  end
end

