module ActiveAdmin
  module Cms
    module ControllerExtensions
      def current_page
        @current_page ||= ActiveAdmin::Cms::Page::for_url request.path
      end       
    end
  end
end

ActionController::Base.send :include, ActiveAdmin::Cms::ControllerExtensions 
