require 'spec_helper'

describe ActionController::Base do
  before :each do
    class NewPageType < ActiveAdmin::Cms::Page
    end
  end

  describe '.cms_for' do
    it 'should set current_page_class to the specified page class' do
      controller.class.cms_for NewPageType
      controller.class.current_page_class.should == NewPageType
    end

  end

  describe '.current_page_class' do
    before :each do
      # reset the controller class variables in case they are polluted by previous calls to cms_for
      controller.class.cms_for nil
    end
    it 'should default to the active admin page type' do
      controller.class.current_page_class.should == ActiveAdmin::Cms::Page
    end
  end

  describe '#current_page' do

    context 'when there are pages' do

      before :each do
        @home_page = FactoryGirl.create(:page, :url => '/')
        @other_page = FactoryGirl.create(:page, :url => '/other')
      end

      it 'should return @home_page when the url = /' do
        controller.request.path = '/'
        controller.current_page.should == @home_page.becomes(controller.current_page.class)
      end

      it 'should assign the current page to an instance variable' do
        controller.request.path = '/'
        page = controller.current_page
        assigns(:current_page).should == page 
      end

      it 'should return @other_page when the url = /other' do
        controller.request.path = '/other'
        controller.current_page.should == @other_page.becomes(controller.current_page.class)
      end

      context 'by default' do
        it 'should return an instance of ActiveAdmin::Cms::Page' do
          controller.request.path = '/'
          controller.current_page.should be_a ActiveAdmin::Cms::Page 
        end
      end

      context 'when an alternative page class has been specified' do
        before :each do
          controller.class.cms_for NewPageType
        end
        it 'should return an instance of that class' do
          controller.request.path = '/'
          controller.current_page.should be_a NewPageType
        end
      end

    end

  end

end
