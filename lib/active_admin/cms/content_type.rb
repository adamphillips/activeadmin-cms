module ActiveAdmin
  module Cms
    class ContentType
      include ActiveAdmin::Cms::Utility::ClassLevelInheritableAttributes
      cattr_inheritable :text_allowed, :markdown_allowed, :text_required, 
                        :image_allowed, :image_required, 
                        :file_allowed, :file_required, 
                        :input_field,
                        :input_opts,
                        :description,
                        :partial,
                        :display_preview, :preview_options,
                        :options

      @text_allowed = false
  :A
      @markdown_allowed = false
      @text_required = false
      @image_allowed = false
      @image_required = false
      @file_allowed = false
      @file_required = false
      
      @input_field = :text
      @input_opts = {:as => :string}
      @description = ''
      @partial = nil
      @display_preview = false
      @preview_options = {}
      @options = {}

      class << self

        def text_allowed?
          @text_allowed
        end

        def markdown_allowed?
          @markdown_allowed
        end

        def text_required?
          @text_required
        end
        
        def image_allowed?
          @image_allowed
        end

        def image_required?
          @image_required
        end
        
        def file_allowed?
          @file_allowed
        end

        def file_required?
          @file_required
        end
        
        def image_uploader
          ActiveAdmin::Cms::Uploaders::ContentImageUploader
        end

        def display_preview?
          @display_preview
        end
      end
    end
  end
end

