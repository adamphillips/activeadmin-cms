module ActiveAdmin
  module Cms
    class Recipe
      class Section

        include ActiveAdmin::Cms::Recipes::SectionHelper::SectionContainer
        
        attr_accessor :id, :options

        @content = {}

        def initialize(id, opts={}, &block)
          
          #debugger

          opts[:partial] ||= 'cms/recipes/section'
          opts[:class] ||= ''
          
          @id = id
          @options = opts

          if block
            self.instance_eval &block
          end
        end

        def section(id, opts={}, &block)
          #super(id, opts)
          super
          sections[id].parent = self
        end

      end
    end
  end
end
