module Jekyll
  module HelperFilters
    def screenshot url, title='', alt=''
      alt ||= "Screenshot of #{title}"
      "<div class=\"screenshot_container\"><p>#{title}</p><img src=\"#{url}\" alt=\"#{alt}\" title=\"#{title}\" /></div>"
    end
  end
end

Liquid::Template.register_filter(Jekyll::HelperFilters)
