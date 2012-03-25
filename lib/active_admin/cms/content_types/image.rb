module ActiveAdmin
  module Cms
    module ContentTypes
      class Image < Cms::ContentType

        @image_allowed = true
        @image_required = true
   
        @input_field = :image
        @input_opts = {:as => :file}

        @display_preview = true
        @preview_options = {:version => :small}
      end
    end
  end
end
