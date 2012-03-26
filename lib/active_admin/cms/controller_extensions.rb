module ActiveAdmin
  module Cms
    module ControllerExtensions
      module ClassMethods
        include ActiveAdmin::Cms::Utility::ClassLevelInheritableAttributes
        cattr_inheritable :current_page_class 

        def cms_for page_class
          @current_page_class = page_class
        end

        def current_page_class
          @current_page_class ||= ActiveAdmin::Cms::Page
        end
      end    
      
      module InstanceMethods
        def current_page
          @current_page ||= self.class.current_page_class::for_url request.path
        end
      end
    end
  end
end

ActionController::Base.send :extend, ActiveAdmin::Cms::ControllerExtensions::ClassMethods
ActionController::Base.send :include, ActiveAdmin::Cms::ControllerExtensions::InstanceMethods
