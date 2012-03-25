require 'active_admin/cms/recipe/ingredient'
require 'active_admin/cms/recipe/section'

module ActiveAdmin
  module Cms
    module Recipes
      module SectionHelper
        module SectionContainer

          class Ingredient < ActiveAdmin::Cms::Recipe::Ingredient; end
          class Section < ActiveAdmin::Cms::Recipe::Section; end

          attr_accessor :parent

          def method_missing(method, *args, &block)
            
            begin
              klass = "ActiveAdmin::Cms::ContentTypes::#{method.to_s.camelcase}".constantize
            rescue NameError
            end

            if klass && klass.new.kind_of?(ActiveAdmin::Cms::ContentType)
              args[2] = args[1]
              args[1] = klass
              ingredient *args
            else
              super
            end
          end

          # Adds formatastic fields to the specified form
          def add_fields_to(formtastic_form)
              fields = {}
              formtastic_form.inputs admin_fieldset_title do
                ingredients.each do |i_id, i|
                  page = formtastic_form.object
                  content = page.content_for i.content_key
                  #debugger
                  fields[i.content_key] = formtastic_form.fields_for(content) do |i_form|     
                      i_form.input :text
                  end
                  #i.add_fields_to(formtastic_form) if i.kind_of? ActiveAdmin::Cms::Recipe::Ingredient
                end
              end
              sections.each do |s_id, s|
                fields[s_id] = s.add_fields_to(formtastic_form) if s.kind_of? ActiveAdmin::Cms::Recipe::Section
              end
            
            #debugger
            
            formtastic_form.inputs
            
          end

          def admin_fieldset_title
            section_id.to_s.humanize
          end
          
          def ingredient(ingredient_id, type, opts={})
            @ingredients ||= {}
            @ingredients[ingredient_id] = Ingredient.new(ingredient_id, type, opts)
            @ingredients[ingredient_id].section = self
            @ingredients[ingredient_id]
          end
    
          def ingredients
            @ingredients ||= {}
          end

          def section(section_id, opts={}, &block)
            
            s = Section.new(section_id, opts, &block)
            @sections ||= {}
            @sections[section_id] = s
            s
          end

          def sections
            @sections ||= {}
          end

          def section_id
            self.id
          end

          def section_key
            return "#{@parent.section_key}:#{section_id.to_s}" if @parent
            section_id.to_s
          end
        end
      end
    end
  end
end
