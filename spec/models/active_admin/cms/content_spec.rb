require 'spec_helper'

describe ActiveAdmin::Cms::Content do

  describe 'mass assignment' do
    it 'should support mass-assignment of the public fields' do
      @content = FactoryGirl.create(:content)

      @content.update_attributes({
        :page => FactoryGirl.create(:page),
        :text => '123',
        :key => 'xyz',
        :image => 'img1',
        :file => 'file1'
      })
    end
  end

  describe '#text' do
    before :each do
      @content = FactoryGirl.create(:content)
    end

    it 'should support markdown' do
      text = '# Test Heading'
      @content.text = text
      @content.text.to_html.should == "<h1>Test Heading</h1>\n"
    end
  end
  
  describe 'setting content types' do

    before :each do
      @content = FactoryGirl.create(:content)
    end

    subject {@content}

    describe '#content_type' do

      subject {@content.content_type}

      context 'when content_type_class has been set' do
        before :each do
          @content.content_type_class = 'ActiveAdmin::Cms::ContentTypes::Text'
        end

        it {should == ActiveAdmin::Cms::ContentTypes::Text}
      end

      context 'when content_type_class has not been set should default to string' do
        it {should == ActiveAdmin::Cms::ContentTypes::String}
      end
    end

    describe '#content_type=' do
      context 'when a class is passed' do
        
        before :each do
          @content.content_type = ActiveAdmin::Cms::ContentTypes::Text
        end

        describe '#content_type_class' do
          subject {@content.content_type_class}
          
          it {should == 'ActiveAdmin::Cms::ContentTypes::Text'}
        end
      end
    end
  end

  describe '#set_content' do
    before :each do
      @content = FactoryGirl.create(:content)
    end

    context 'when the content type is string' do      
      before :each do
        @content.content_type = ActiveAdmin::Cms::ContentTypes::String
      end

      it 'should set the text field' do
        @content.should_receive('text=').with('new content')
        @content.set_content('new content')
      end
    end

    context 'when the content type is string' do      
      before :each do
        @content.content_type = ActiveAdmin::Cms::ContentTypes::Image
      end

      it 'should set the image field' do
        @content.should_receive('image=').with('new content')
        @content.set_content('new content')
      end
    end
  end

  describe '#to_html' do
    context 'when the content type allows text' do
      before :each do
        @test_text = '123321'
        @content = FactoryGirl.create(:content, :content_type => ActiveAdmin::Cms::ContentTypes::String,  :text => @test_text)
      end

      it 'should return the text rendered as html' do
        #debugger
        @content.to_html.should == @test_text
      end
    end
  end

  describe 'uploaders' do
    before :each do
      @content = FactoryGirl.create(:content)
    end

    describe '#image_uploader' do
      context 'by default' do
        it 'should be the default image uploader' do
          @content.image_uploader.should == ActiveAdmin::Cms::Uploaders::ContentImageUploader
          @content.image.respond_to?(:large).should be_false
        end
      end
      context 'when the content type has been set to one that doesn`t change the image uploader' do
        before :each do
          @content = FactoryGirl.create(:image_content)
        end
        it 'still uses the default image uploader' do
          @content.image_uploader.should == ActiveAdmin::Cms::Uploaders::ContentImageUploader
          @content.image.respond_to?(:large).should be_false
        end
      end
      context 'when the content type has been set to one that uses a different image uploader' do
        before :each do
          @content = ActiveAdmin::Cms::Content.new(:content_type_class => 'ActiveAdmin::Cms::ContentTypes::LargeImage')
        end
        it 'uses the uploader associated with the content type' do
          #debugger
          @content.image_uploader.should == ActiveAdmin::Cms::Uploaders::LargeImageUploader
        end
        it 'should attach the new uploader' do
          #debugger
          @content.image.respond_to?(:large).should be_true
        end
      end
    end
  end

end
