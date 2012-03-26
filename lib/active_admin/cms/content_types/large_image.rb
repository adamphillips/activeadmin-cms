module ActiveAdmin
  module Cms
    module ContentTypes
      class LargeImage < Cms::ContentType

        @image_allowed = true
        @image_required = true
   
        @input_field = :image
        @input_opts = {:as => :file}

        @display_preview = true
        @preview_options = {:version => :small}

        def self.image_uploader
          ActiveAdmin::Cms::Uploaders::LargeImageUploader
        end
      end
    end
  end
end
