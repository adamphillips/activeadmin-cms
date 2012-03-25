require 'spec_helper'

describe ActiveAdmin::Cms::Recipe::Section do

  it_behaves_like 'a recipe section container', :test_instance => ActiveAdmin::Cms::Recipe::Section.new(:test_section)

  describe '#initialize' do
    context 'when just an id is specified' do
      subject {ActiveAdmin::Cms::Recipe::Section.new :test_section}
      describe 'the new section' do
        its(:id) {should == :test_section}
      end
    end

    context 'when an id plus a hash of options are passed' do

      before :each do
        @section = ActiveAdmin::Cms::Recipe::Section.new :test_section, :partial => 'something_different'
      end

      subject {@section}
      describe 'the new section' do
        its(:id) {should == :test_section}

        describe '.options' do
          subject {@section.options}
          its([:partial]) {should == 'something_different'}
        end
      end
    end

    context 'when an id plus a block of ingredient data are passed' do

      before :each do
        @section = ActiveAdmin::Cms::Recipe::Section.new :test_section do
          ingredient :test_ingredient, ActiveAdmin::Cms::ContentTypes::Text
        end
      end

      subject {@section}
      describe 'the new section' do
        its(:id) {should == :test_section}

        describe '.ingredients' do
          subject {@section.ingredients}

          it {should_not be_nil}
          its(:length) {should == 1}
          its([:test_ingredient]) {should_not be_nil}

          describe 'the created ingredient' do
            subject {@section.ingredients[:test_ingredient]}
  
            its(:id) {should == :test_ingredient}
            its(:content_type) {should == ActiveAdmin::Cms::ContentTypes::Text}
          end
        end
      end
    end
  end

  describe '#section' do

    before :each do
      @section = ActiveAdmin::Cms::Recipe::Section.new :test_section 
    end

    context 'when adding a section with just an id' do

      before :each do
        @section.section :test_section
      end

      describe 'the created section' do

        subject{@section.sections[:test_section]}

        its(:parent) {should == @section}

      end

    end
  
  end

end
