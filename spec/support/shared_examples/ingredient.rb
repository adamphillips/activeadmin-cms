shared_examples 'an ingredient' do |opts={}|

  describe '#input_settings' do
    context "when the ingredient has a content type of text" do
      before :each do
        @ingredient = ActiveAdmin::Cms::Recipe::Ingredient.new :test_ingredient, ActiveAdmin::Cms::ContentTypes::Text
      end

      subject {@ingredient.input_settings}

      it {should be_kind_of Array}
      its([0]) {should == ActiveAdmin::Cms::ContentTypes::Text.input_field}
      its([1]) {should == {:input_html => {:name => "content[#{@ingredient.content_key}]", :id => @ingredient.content_key.to_s.gsub(':', '__')}, :label => @ingredient.title, :as => :text}}
    end

    context 'when the ingredient has a content type of image' do
      before :each do
        @ingredient = ActiveAdmin::Cms::Recipe::Ingredient.new :test_ingredient, ActiveAdmin::Cms::ContentTypes::Image
      end

      subject {@ingredient.input_settings}

      it {should be_kind_of Array}
      its([0]) {should == ActiveAdmin::Cms::ContentTypes::Image.input_field}
      its([1]) {should == {:input_html => {:name => "content[#{@ingredient.content_key}]", :id => @ingredient.content_key.to_s.gsub(':', '__')}, :label => @ingredient.title, :as => :file}}
    end
  end

end
