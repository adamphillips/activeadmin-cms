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

        # Whether this content type allows text
        def text_allowed?
          @text_allowed
        end

        # Whether this content type supports markdown-formatted text
        def markdown_allowed?
          @markdown_allowed
        end

        # Whether text is mandatory for this piece of content
        def text_required?
          @text_required
        end

        # Whether this content type allows an image to be uploaded
        def image_allowed?
          @image_allowed
        end

        # Wether this content type requires an image
        def image_required?
          @image_required
        end

        # Whether this content type allows a file to be uploaded
        def file_allowed?
          @file_allowed
        end

        # Wether this content type requires a file
        def file_required?
          @file_required
        end

        # The CarrierWave Uploader used by this content type for images
        def image_uploader
          ActiveAdmin::Cms::Uploaders::ContentImageUploader
        end

        # Whether a preview should be displayed in ActiveAdmin
        def display_preview?
          @display_preview
        end
      end
    end
  end
end

