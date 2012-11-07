require "generator_spec/test_case"
require 'generators/active_admin/cms/install/install_generator'

describe ActiveAdmin::Cms::InstallGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../tmp", __FILE__)
  arguments %w()

  before(:all) do
    prepare_destination
    run_generator
  end

  it 'should create the correct files' do
    destination_root.should have_structure {
      directory "config" do
        directory "initializers" do
          file "active_admin-cms.rb" do
            contains "module ActiveAdmin::Cms"
          end
        end
      end
      directory "db" do
        directory "migrate" do
          migration "install_aacms" do
            contains "class InstallAacms < ActiveRecord::Migration"
            contains "create_table :content"
            contains "create_table :recipes"
          end
        end
      end
    }
  end

end
