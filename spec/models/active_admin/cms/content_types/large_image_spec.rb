require 'spec_helper'

describe ActiveAdmin::Cms::ContentTypes::LargeImage do

  it_behaves_like 'a content type', :image_required? => true, :input_field => :image, :input_opts => {:as => :file}, :display_preview? => true, :preview_options => {:version => :small}

end
