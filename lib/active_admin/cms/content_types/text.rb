module ActiveAdmin
  module Cms
    module ContentTypes
      class Text < Cms::ContentType
        @text_required = true
        @text_allowed = true
        @markdown_allowed = true

        @input_opts = {:as => :text}
      end
    end
  end
end
