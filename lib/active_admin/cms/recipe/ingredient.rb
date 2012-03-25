module ActiveAdmin
  module Cms
    class Recipe
      class Ingredient

        attr_accessor :id, :content_type, :section,
                      :title, :description, :options

        def initialize(id, content_type, opts = {})
          @id = id
          @content_type = content_type
          @options = opts
        end

        def add_fields_to(formtastic_form)
          page = formtastic_form.object
          content = page.content_for content_key
          #debugger
          fields = formtastic_form.fields_for(content) do |i_form|     
            i_form.inputs do
              i_form.input :text
            end
          end
          #debugger
          fields
        end

        # returns the key to use for storing content
        def content_key
          return "#{section.section_key}:#{id}" if section
          id
        end 

        def input_settings opts = {}
          opts[:prefix]
          
          input_options = {:label => title, :input_html => {:name => "content[#{content_key}]", :id => content_key.to_s.gsub(':', '__')}}
          
          input_options[:hint] ||= description if description
          input_options[:hint] ||= content_type.description if !description and !content_type.description.blank?
          input_options.merge! @options if @options
          #debugger
          [
            content_type.input_field,
            input_options.merge(content_type.input_opts)
          ]
        end

        def title
          @title ||= id.to_s.humanize
        end

      end
    end
  end
end
