module ActiveAdmin
  module Cms
    class Content < ActiveRecord::Base
      
      include ActionView::Helpers
      include Haml::Helpers

      self.table_name = 'content'

      belongs_to :page, :class_name => 'Cms::Page'
    
      #acts_as_markdown :text

      #mount_uploader :image, ActiveAdmin::Cms::Uploaders::ContentImageUploader
      #mount_uploader :file, ActiveAdmin::Cms::Uploaders::ContentFileUploader

      #process_in_background :image
      #process_in_background :file

      def content_type
        content_type_class.constantize if content_type_class
      end

      def content_type_class
        super || 'ActiveAdmin::Cms::ContentTypes::String'
      end

      def content_type=(type)
        update_attribute :content_type_class, type.to_s
      end

      def set_content(value)
        self.send("#{self.content_type.input_field}=", value)
      end

      def to_html(options = {})
        #debugger
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
