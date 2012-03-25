describe ActiveAdmin::Cms::Recipe::Ingredient do

  it_behaves_like 'an ingredient'
  
  describe '#content_key' do
  
    before :each do
      @ingredient = ActiveAdmin::Cms::Recipe::Ingredient.new :test_ingredient, ActiveAdmin::Cms::ContentTypes::Text
    end
    
    subject {@ingredient.content_key}

    context 'when the ingredient has no section' do
      it {should == @ingredient.id}      
    end

    context 'when the ingredient has a section' do
      before :each do
        @section = ActiveAdmin::Cms::Recipe::Section.new :test_section
        @ingredient.section = @section
      end

      it {should == "#{@section.section_key}:#{@ingredient.id}"}
    end

  end

  describe '#title' do
    before :each do
      @ingredient = ActiveAdmin::Cms::Recipe::Ingredient.new :test_ingredient, ActiveAdmin::Cms::ContentTypes::Text
    end

    subject {@ingredient.title}
    
    context 'when the title hasn`t been explicitly set' do

      it {should == 'Test ingredient'}
    end
    
    context 'when the title has been explicitly set' do
      before :each do
        @ingredient.title = 'New Title'
      end
      
      it {should == 'New Title'}
    end
  end

end
