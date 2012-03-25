module ActiveAdmin
  module Cms
    class Page < ActiveRecord::Base
      validates :title, :presence => true
      validates :recipe_id, :presence => true
    
      belongs_to :recipe

      has_many :content
      accepts_nested_attributes_for :content

      class << self

        def for_url(url)
          where(:url => url).first if where(:url => url).any?
        end

      end

      def content_for content_key
        ret = nil
        if recipe
          if recipe.contains_content_key?(content_key)
            ret = Cms::Content.where(:page_id => id, :key => content_key)
            if ret.length == 0
              ret = Cms::Content.new(:page => self, :key => content_key)
              ret.content_type = recipe.ingredient_for(content_key).content_type
            else
              ret = ret[0]
            end
          #else
            #raise Cms::Exceptions::InvalidContentKey
          end
        end
        return ret
      end

      def meta_data
        data = {}
        if meta_title and !meta_title.blank?
          data[:title] = meta_title
        elsif title and !title.blank?
          data[:title] = "#{Cms::SITE_TITLE} | #{title}"
        else
          data[:title] = Cms::SITE_TITLE
        end
        data[:description] = meta_description || Cms::DEFAULT_META_DESCRIPTION
        data[:keywords] = meta_keywords || Cms::DEFAULT_META_KEYWORDS
        data
      end

      # Takes a content_key => text hash and sets the text value for each of the content records
      def set_value content_hash
        if content_hash
          content_hash.each do |key, value|
            c = content_for(key)
            #debugger
            if c
              c.set_content value
              c.save
            end
          end
        end
      end

      def set_content content_key, content
        if content.kind_of? Cms::Content
          content.key = content_key
          content.page = self
          content.content_type = recipe.ingredient_for(content_key).content_type
          content.save
        end
      end
    end
  end
end

