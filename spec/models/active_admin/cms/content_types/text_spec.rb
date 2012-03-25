require 'spec_helper'

describe ActiveAdmin::Cms::ContentTypes::Text do

  it_behaves_like 'a content type', :markdown_allowed? => true, :text_required? => true, :input_opts => {:as => :text}

end
