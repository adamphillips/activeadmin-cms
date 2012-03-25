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

  specify do
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

