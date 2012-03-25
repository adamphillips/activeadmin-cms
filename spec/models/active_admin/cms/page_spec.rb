require 'spec_helper'

describe ActiveAdmin::Cms::Page do

  describe '::for' do
    context 'given there is a page with a url' do
      before :each do
        #debugger
        @page_1 = FactoryGirl.create(:page, :url => '/athing')
        @page_2 = FactoryGirl.create(:page, :url => '/something')
      end

      context 'when passed a url' do

        subject{Page::for_url('/something')}

        it {should == @page_2}

      end
    end
  end

  describe '#content_for' do
    before :each do
      @page = FactoryGirl.create(:page)
    end

    context 'when the page doesn`t have a recipe' do
      subject {@page.content_for 'anything'}
      it {should be_nil}
    end

    context 'when the page has a recipe' do
      before :each do
        @recipe = FactoryGirl.create(:basic_recipe)
        @page.recipe = @recipe
        @page.save
      end
      context 'when a content key is passed that is not valid for the specified recipe' do
        subject {@page.content_for 'something:stupid'}
        it {should be_nil}
      end
      context 'when a valid content key is passed' do
        before :each do
          ActiveAdmin::Cms::Content.delete_all
        end

        context 'when there isn`t already content with the specified page and content key' do

          context 'for a text ingredient' do
            subject {@page.content_for('column:text_ingredient_1')}

            it {should_not be_nil}
            it {should be_kind_of ActiveAdmin::Cms::Content}
            its(:page) {should == @page}
            its(:content_type) {should == ActiveAdmin::Cms::ContentTypes::Text}
            its('text.to_s') {should == ''}
          end
          
          context 'for a image ingredient' do
            subject {@page.content_for('column:image_ingredient_1')}

            it {should_not be_nil}
            it {should be_kind_of ActiveAdmin::Cms::Content}
            its(:page) {should == @page}
            its(:content_type) {should == ActiveAdmin::Cms::ContentTypes::Image}
            its('text.to_s') {should == ''}
          end
        end

        context 'when there is already content with the specified page and content key' do

          before :each do
            @text_content = FactoryGirl.create(:text_content, :key => 'column:text_ingredient_1', :page => @page, :text => '123')
            #debugger
            @image_content = FactoryGirl.create(:image_content, :key => 'column:image_ingredient_1', :page => @page)
            
          end

          context 'when searching for the text ingredient' do
            subject {@page.content_for('column:text_ingredient_1')}

            it {should_not be_nil}
            it {should == @text_content}
          end
          
          context 'when searching for the image ingredient' do
            subject {@page.content_for('column:image_ingredient_1')}

            it {should_not be_nil}
            it {should == @image_content}
          end
        end
      end
    end
  end

  describe '#meta_data' do

    subject {@page.meta_data}

    before :each do
      @page = FactoryGirl.create(:page, :recipe => Factory(:basic_recipe))
    end

    it {should be_kind_of Hash}

    describe '[:title]' do

      subject {@page.meta_data[:title]}

      context 'when the page has a title' do
        before :each do
          @page.title = 'A page'
          @page.save
        end
        context 'when the page has a specific meta title set' do
          before :each do
            @page.meta_title = 'A title'
            @page.save
          end

          it {should == @page.meta_title}
        end
        context 'when the page doesn`t have a specific meta title' do
          it {should == "#{ActiveAdmin::Cms::SITE_TITLE} | #{@page.title}"}  
        end
      end

      context 'when the page doesn`t have a title' do
        before :each do
          @page.title = ''
          @page.save
        end
        context 'when the page has a specific meta title set' do
          before :each do
            @page.meta_title = 'A title'
            @page.save
          end

          it {should == @page.meta_title}
        end
        context 'when the page doesn`t have a specific meta title' do
          it {should == "#{ActiveAdmin::Cms::SITE_TITLE}"}  
        end
      end
    end

    describe '[:description]' do
      subject {@page.meta_data[:description]}

      context 'when meta description has been set' do
        before :each do
          @page.meta_description = 'desc 123'
          @page.save
        end
        it {should == @page.meta_description}
      end

      context 'when meta keywords have not been set' do
        it {should == ActiveAdmin::Cms::DEFAULT_META_DESCRIPTION}
      end
    end

    describe '[:keywords]' do
      subject {@page.meta_data[:keywords]}

      context 'when meta keywords have been set' do
        before :each do
          @page.meta_keywords = 'key 123'
          @page.save
        end
        it {should == @page.meta_keywords}
      end

      context 'when meta keywords have not been set' do
        it {should == ActiveAdmin::Cms::DEFAULT_META_KEYWORDS}
      end
    end
  end

  describe '#set_content' do

    subject{@page}

    before :each do
      @page = FactoryGirl.create(:page, :recipe => Factory(:basic_recipe))
    end

    context 'when the content_key is valid for the pages recipe' do

      context 'when given an existing content item' do

        before :each do
          @content = FactoryGirl.create(:content)
          @page.set_content 'column:text_ingredient_1', @content
        end

        subject{@page.content.reload}

        its(:length) {should == 1}

        describe 'the passed content item' do
          subject {@content.reload}
          
          its(:key) {should == 'column:text_ingredient_1'}
        end 

        describe 'the created content item' do
          subject{@page.content_for('column:text_ingredient_1')}

          its(:id) {should == @content.id}
          its('text.to_s') {should == @content.text.to_s}
          its(:content_type_class) {should == @content.content_type_class}
        end
      end
    end
    context 'when an invalid content_key is passed' do
    
      pending 'it should throw an error'

    end

  end

  describe '#set_value' do
    before :each do
      @page = FactoryGirl.create(:page, :recipe => Factory(:basic_recipe))
    end

    context 'when passed a content_key => text hash' do
      it 'should set the text for each of the of the content records' do
      @page.set_value 'column:text_ingredient_1' => '123', 'footer:address' => '456'

      @page.content_for('column:text_ingredient_1').text.to_s.should == "123"
      @page.content_for('footer:address').text.to_s.should == '456'
end
    end
  end

end
