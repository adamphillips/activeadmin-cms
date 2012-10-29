require 'spec_helper'

describe ActiveAdmin::Cms::Recipe do

  it_behaves_like 'a recipe section container'

  describe '#add_fields_to' do
    context 'when a formtastic form is passed' do
    end
  end

  describe '#contains_content_key?' do
    before :each do
      @recipe = FactoryGirl.create(:basic_recipe)
    end

    context 'when passed a content key contained in the recipe' do
      subject {@recipe.contains_content_key?('column:text_ingredient_1')}
      it {should be_true}
    end
    context 'when passed a content key not contained in the recipe' do
      subject {@recipe.contains_content_key?('absolute:nonsense')}
      it {should be_false}
    end
  end

  describe '#define' do

    context 'when a recipe section block is passed' do
      before :each do
        @recipe = FactoryGirl.create(:recipe)

        @recipe.define do
          section :test_section do
            ingredient :test_ingredient, ActiveAdmin::Cms::ContentTypes::Text
          end
        end
      end

      describe 'the recipes sections' do
        subject {@recipe.sections}

        it {should_not be_nil}

        its(:length) {should == 1}
        its([:test_section]) {should_not be_nil}

        describe '[:test_section]' do

          subject {@recipe.sections[:test_section]}
          
          its(:id) {should == :test_section}
          its(:ingredients) {should_not be_nil}

          describe '.ingredients' do

            subject {@recipe.sections[:test_section].ingredients}

            its(:length) {should == 1}
            its([:test_ingredient]) {should_not be_nil}


            describe '[:test_ingredient]' do

              subject {@recipe.sections[:test_section].ingredients[:test_ingredient]}

              its(:id) {should == :test_ingredient}
              its(:content_type) {should == ActiveAdmin::Cms::ContentTypes::Text}

            end

          end

        end
        
      end 

    end

  end

  describe '#ingredient_for' do
    before :each do
      @recipe = FactoryGirl.create(:basic_recipe)
    end

    context 'when passed a content key contained in the recipe' do
      describe ':test 1 - text' do
        subject {@recipe.ingredient_for('column:text_ingredient_1')}
        it {should_not be_nil}
        it {should == @recipe.sections[:column].ingredients[:text_ingredient_1]}
      end
      
      describe ':test 2 - image' do
        subject {@recipe.ingredient_for('column:image_ingredient_1')}
        it {should_not be_nil}
        it {should == @recipe.sections[:column].ingredients[:image_ingredient_1]}
      end
      
      describe ':test 3 - footer text' do
        subject {@recipe.ingredient_for('footer:address')}
        it {should_not be_nil}
        it {should == @recipe.sections[:footer].ingredients[:address]}
      end
    end
    context 'when passed a content key not contained in the recipe' do
      subject {@recipe.ingredient_for('absolute:nonsense')}
      it {should be_nil}
    end
  end
end
