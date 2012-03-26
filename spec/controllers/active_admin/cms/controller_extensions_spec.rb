require 'spec_helper'

describe ActionController::Base do

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

    end

  end

end
