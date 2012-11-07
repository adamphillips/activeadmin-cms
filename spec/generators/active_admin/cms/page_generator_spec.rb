require "generator_spec/test_case"
require 'generators/active_admin/cms/page/page_generator'

describe ActiveAdmin::Cms::PageGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w(Page)

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'should create the correct files' do
    destination_root.should have_structure {
      no_file "test.rb"
      directory "app" do
        directory "admin" do
          file "pages.rb" do
            contains 'ActiveAdmin.register Page'
           end
        end
        directory "models" do
          file "page.rb" do
            contains "class Page < ActiveAdmin::Cms::Page"
          end
        end
        directory "views" do
          directory "admin" do
            directory "cms" do
              directory "pages" do
                file "_form.html.haml" do
                  contains "form_for"
                end
                file "_ingredient.html.haml"
                file "_section.html.haml"
                file "_show.html.haml"
              end
            end
          end
        end
      end
      directory "db" do
        directory "migrate" do
          migration "create_pages" do
            contains "class CreatePages < ActiveRecord::Migration"
          end
        end
      end
    }
  end

end

