require 'spec_helper'

describe ActiveAdmin::Cms::ContentTypes::TextAndImage do

  it_behaves_like 'a content type', :text_required? => true, :image_required? => true

end
