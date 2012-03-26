module ActiveAdmin
  module Cms
    module CmsHelper
      def cms_content page, content_key, options = {}
        raise Exceptions::MissingPage if !page
        #debugger
        page.content_for(content_key).to_html(options).html_safe if page.content_for(content_key)
      end
    end
  end
end

ActionView::Base.send :include, ActiveAdmin::Cms::CmsHelper
