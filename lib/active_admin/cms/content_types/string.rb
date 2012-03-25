module ActiveAdmin
  module Cms
    module ContentTypes
      class String < Cms::ContentType
        @text_required = true
        @text_allowed = true
      end
    end
  end
end
