require 'haml'
require 'carrierwave'
require 'carrierwave_backgrounder'
require 'carrierwave/orm/activerecord'

require 'active_admin/cms/helpers/cms_helper'
require 'active_admin/cms/utility/class_level_inheritable_attributes'

module ActiveAdmin
  module Cms
    module ContentTypes
    end
    module Recipes
      module SectionHelper
        module SectionContainer
        end
      end
    end
    module Uploaders
    end
  end
end

require 'acts_as_markup'
require 'acts_as_markup/railtie'
require 'acts_as_markup/active_record_extension'
require 'acts_as_markup/stringlike'

ActsAsMarkup.markdown_library = :rdiscount

require 'active_admin/cms/uploaders/content_file_uploader'
require 'active_admin/cms/uploaders/content_image_uploader'
require 'active_admin/cms/uploaders/large_image_uploader'

require 'active_admin/cms/content'
require 'active_admin/cms/content_type'
require 'active_admin/cms/controller_extensions'
require 'active_admin/cms/page'
require 'active_admin/cms/recipe'

ActiveAdmin::Cms::Recipe.autoload :Ingredient, 'active_admin/cms/recipe/ingredient'
ActiveAdmin::Cms::Recipe.autoload :Section, 'active_admin/cms/recipe/section'

require 'active_admin/cms/recipes/section_helper'

ActiveAdmin::Cms::ContentTypes.autoload :LargeImage, 'active_admin/cms/content_types/large_image'
ActiveAdmin::Cms::ContentTypes.autoload :Image, 'active_admin/cms/content_types/image'
ActiveAdmin::Cms::ContentTypes.autoload :String, 'active_admin/cms/content_types/string'
ActiveAdmin::Cms::ContentTypes.autoload :Text, 'active_admin/cms/content_types/text'
ActiveAdmin::Cms::ContentTypes.autoload :TextAndImage, 'active_admin/cms/content_types/text_and_image'
#require 'active_admin/cms/content_types/image'
#require 'active_admin/cms/content_types/string'
#require 'active_admin/cms/content_types/text'
#require 'active_admin/cms/content_types/text_and_image'
