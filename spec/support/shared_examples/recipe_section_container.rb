shared_examples 'a recipe section container' do |opts = {}|

  opts[:test_instance] ||= described_class.new

  before :each do
    @test_instance = opts[:test_instance]
  end

  #describe '#admin_fieldset_title' do
    #subject {@test_instance.admin_fieldset_title}
    #context 'when the instance has an id' do
      #before :each do
        #@test_instance.id = :test_instance
      #end
      #it {should == 'Test instance'}
    #end
  #end

  describe 'ingredients' do
    describe '#add_ingredient' do
      context 'when passed a symbol and a type' do
        before :each do
          @test_instance.ingredient :test_ingredient, ActiveAdmin::Cms::ContentTypes::Text
        end

        describe '#ingredients' do
          subject {@test_instance.ingredients[:test_ingredient]}

          it {should_not be_nil}

          describe 'the created ingredient' do

            before :each do
              #debugger
              @test_instance
            end

            it {should be_kind_of ActiveAdmin::Cms::Recipe::Ingredient}
            
            describe '.id' do
              subject {@test_instance.ingredients[:test_ingredient].id}
              it {should == :test_ingredient}
            end
            
            describe '.content_type' do
              subject {@test_instance.ingredients[:test_ingredient].content_type}
              it {should == ActiveAdmin::Cms::ContentTypes::Text}
            end

            describe '.section' do
              subject {@test_instance.ingredients[:test_ingredient].section}
              it {should == @test_instance}
            end
          end
        end
      end
    end

    describe 'dynamic helpers' do
      context 'when a method is called that can be mapped to a content type' do
        before :each do
          @test_instance.text :test_ingredient
        end
        
        describe '#ingredients' do
          subject {@test_instance.ingredients[:test_ingredient]}

          it {should_not be_nil}

          describe 'the created ingredient' do

            before :each do
              #debugger
              @test_instance
            end

            it {should be_kind_of ActiveAdmin::Cms::Recipe::Ingredient}
            
            describe '.id' do
              subject {@test_instance.ingredients[:test_ingredient].id}
              it {should == :test_ingredient}
            end
            
            describe '.content_type' do
              subject {@test_instance.ingredients[:test_ingredient].content_type}
              it {should == ActiveAdmin::Cms::ContentTypes::Text}
            end
          end
        end
      end
    end
  end
  
  describe '#section' do
    context 'when passed a symbol' do
      before :each do
        @test_instance.section :test_section
      end

      describe '#sections' do
        subject {@test_instance.sections[:test_section]}

        it {should_not be_nil}

        describe 'the created section' do
          it {should be_kind_of ActiveAdmin::Cms::Recipe::Section}
          
          describe '.id' do
            subject {@test_instance.sections[:test_section].id}
            it {should == :test_section}
          end

          describe '.options' do
            subject {@test_instance.sections[:test_section].options}
            
            its([:partial]) {should == 'cms/recipes/section'}
            its([:class]) {should == ''}
          end
        end
      end
    end

    context 'when passed a symbol and a hash of options' do
      before :each do
        @test_instance.section :test_section, :class => 'test_section_class'
      end

      describe '#sections' do
        subject {@test_instance.sections[:test_section]}

        it {should_not be_nil}

        describe 'the created section' do
          it {should be_kind_of ActiveAdmin::Cms::Recipe::Section}
          
          describe '.id' do
            subject {@test_instance.sections[:test_section].id}
            it {should == :test_section}
          end

          describe '.options' do
            subject {@test_instance.sections[:test_section].options}

            context 'an option that was specified in the hash should not be changed' do  
              its([:partial]) {should == 'cms/recipes/section'}
            end

            context 'an option that was not specified in the hash should be overridden' do
              its([:class]) {should == 'test_section_class'}
            end
          end
        end
      end
    end
    
    context 'when passed a symbol and a block' do
      before :each do
        @test_instance.section :test_section do
          ingredient :test_ingredient, ActiveAdmin::Cms::ContentTypes::Text
        end
      end

      describe '#sections' do
        subject {@test_instance.sections[:test_section]}

        it {should_not be_nil}

        describe 'the created section' do
          it {should be_kind_of ActiveAdmin::Cms::Recipe::Section}
          
          describe '.id' do
            subject {@test_instance.sections[:test_section].id}
            it {should == :test_section}
          end

          describe '.options' do
            subject {@test_instance.sections[:test_section].options}
            context 'an option that was not specified in the hash should not be changed' do  
              its([:partial]) {should == 'cms/recipes/section'}
            end
          end

          describe '.ingredients' do
            subject {@test_instance.sections[:test_section].ingredients}

            it {should_not be_nil}
            its(:length) {should == 1}

            describe 'the added ingredient' do
              subject {@test_instance.sections[:test_section].ingredients[:test_ingredient]}

              it {should_not be_nil}
              its(:id) {should == :test_ingredient}
              its(:content_type) {should == ActiveAdmin::Cms::ContentTypes::Text}
            end
          end
        end
      end
    end

  end

  describe '#section_key' do
    subject {@test_instance.section_key}
    
    context 'when the section has no parent' do
      it {should == @test_instance.section_id.to_s}
    end
    
    context 'when the section has a parent' do
      before :each do
        @parent_section = ActiveAdmin::Cms::Recipe::Section.new :parent_section
        @test_instance.parent = @parent_section
      end

      it {should == "#{@parent_section.id}:#{@test_instance.section_id}"}

      context 'when the section`s parent has a parent' do
        before :each do
          @super_parent_section = ActiveAdmin::Cms::Recipe::Section.new :super_parent_section
          @parent_section.parent = @super_parent_section
        end
        it {should == "#{@super_parent_section.id}:#{@parent_section.id}:#{@test_instance.section_id}"}
      end
    end

  end

end


