require 'active_admin/cms/recipes/section_helper'

module ActiveAdmin
  module Cms
    class Recipe < ActiveRecord::Base

      include ActiveAdmin::Cms::Recipes::SectionHelper::SectionContainer

      has_many :pages

      def self.define(&definition_block)
        after_initialize do
          define &definition_block
        end
      end

      def define(&block)
        self.instance_eval &block
      end

      def admin_fieldset_title
        'Content'
      end

      def contains_content_key? content_key
        !!ingredient_for(content_key)
      end
      
      def ingredient_for content_key
        section_keys = content_key.split ':'
        current_section = self
        section_keys.each do |section_id|
          #debugger
          if section_id == section_keys.last
            return current_section.ingredients[section_id.to_sym]
          else
            if current_section.sections[section_id.to_sym]
              current_section = current_section.sections[section_id.to_sym]
            else
              return nil
            end
          end
        end
      end
    end
  end
end
