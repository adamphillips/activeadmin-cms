require 'spec_helper'

describe ActiveAdmin::Cms::Content do
  
  describe 'setting content types' do

    before :each do
      @content = Factory(:content)
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
      @content = Factory(:content)
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
        @content = Factory(:content, :content_type => ActiveAdmin::Cms::ContentTypes::String,  :text => @test_text)
      end

      it 'should return the text rendered as html' do
        #debugger
        @content.to_html.should == @test_text
      end
    end
  end
end
