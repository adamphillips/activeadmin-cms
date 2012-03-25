module ActiveAdmin
  module Cms
    module ContentTypes
      class TextAndImage < Cms::ContentType
        @text_required = true
        @text_allowed = true
        @image_required = true
        @image_allowed = true
      end
    end
  end
end
