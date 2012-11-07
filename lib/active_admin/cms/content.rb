module ActiveAdmin
  module Cms
    class Content < ActiveRecord::Base
      
      include ActionView::Helpers
      include Haml::Helpers

      class << self
        include ActsAsMarkup::ActiveRecordExtension::ClassMethods
      end

      attr_accessible :page, :key, :text, :image, :file, :content_type_class

      self.table_name = 'content'

      belongs_to :page, :class_name => 'Cms::Page'
    
      acts_as_markdown :text
      
      after_initialize do
        self.class.mount_uploader :image, content_type.image_uploader
        self.class.mount_uploader :file, ActiveAdmin::Cms::Uploaders::ContentFileUploader
      end

      # The ContentType subclass of the piece of content
      def content_type
        content_type_class.constantize if content_type_class
      end

      # The name of the ContentType subclass of the piece of content
      # Defaults to ActiveAdmin::Cms::ContentTypes::String
      def content_type_class
        super || 'ActiveAdmin::Cms::ContentTypes::String'
      end

      # Allows setting of the associated ContentType subclass with a string
      # @example
      #  @content.content_type = 'ActiveAdmin::Cms::ContentTypes::Image'
      def content_type=(type)
        update_attribute :content_type_class, type.to_s
      end

      # Returns the CarrierWave Uploader used to process the image for this piece of content
      def image_uploader
        content_type.image_uploader
      end

      # Sets the value of this piece of content.
      # The appropriate field will be populated depending on the type of the content
      def set_content(value)
        self.send("#{self.content_type.input_field}=", value)
      end

      # Returns the HTML for this piece of content
      def to_html(options = {})
        html = ''

        if content_type.text_allowed?
          if content_type.markdown_allowed?
            html += text.to_html
          else
            html += text.to_s
          end
        end

        if content_type.image_allowed?
          if image
            tag_options = options[:tag]
            tag_options ||= {}
            tag_options[:src] ||= image.url(options[:version])
            html += tag(:img, tag_options) if tag_options[:src] != 'missing.png'
          end
        end

        html
      end
    end
  end
end
